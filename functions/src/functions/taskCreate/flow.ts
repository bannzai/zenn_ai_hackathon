import * as functions from "firebase-functions";
import { z } from "genkit";
import { genkitAI, googleSearchGroundingData } from "../../utils/ai/ai";
import {
  TaskPreparedSchema,
  TaskPreparingSchema,
  TaskSchema,
} from "../../entity/task";
import { TODO, TODOSchema } from "../../entity/todo";
import { database } from "../../utils/firebase/firebase";
import {
  DataResponseSchema,
  errorResponse,
  ErrorResponseSchema,
} from "../../entity/response";
import { GroundingDataSchema } from "../../entity/grounding";
import { TaskCreateSchema } from "./input";
import { Timestamp } from "firebase-admin/firestore";
import { zodTypeGuard } from "../../utils/stdlib/type_guard";
import { enqueueTODOPrepare } from "../todoPrepare/enqueue_task";
import { TaskRetryError } from "../../utils/error/taskRetry";
import { errorMessage } from "../../utils/error/message";

const TODOContentFromMarkdownSchema = TODOSchema.pick({
  content: true,
  supplement: true,
});

const todoContentFromMarkdown = genkitAI.defineTool(
  {
    name: "todoContentFromMarkdown",
    description: "todo content from markdown",
    inputSchema: z.string().describe("answer of question. markdown format"),
    outputSchema: z.array(TODOContentFromMarkdownSchema),
  },
  async (input) => {
    console.log(
      `#formatToJSONFromMarkdownAnswer: ${JSON.stringify({ input }, null, 2)}`
    );
    const response = await genkitAI.generate({
      prompt: `${input} の中からTODOリストを抽出して、要素を一つずつ分けて文字列の配列にしてください`,
      output: { schema: z.array(TODOContentFromMarkdownSchema) },
    });
    const output = response.output;
    if (!output) {
      throw new Error("output is null");
    }
    return output;
  }
);

const extractTopic = genkitAI.defineTool(
  {
    name: "extractTopic",
    description: "extract topic",
    inputSchema: z.object({
      question: z.string(),
    }),
    outputSchema: z.string(),
  },
  async (input) => {
    console.log(`#extractTopic: ${JSON.stringify({ input }, null, 2)}`);
    const response = await genkitAI.generate({
      prompt: `「${input.question}」。この質問の対象となるトピックを抜き出してください。例) 「確定申告の方法」だと「確定申告」と答えて欲しいです。「結婚の際にやること」だと「結婚」と答えて欲しいです`,
      output: { schema: z.object({ topic: z.string() }) },
    });
    const topic = response.output;
    if (!topic) {
      throw new Error("topic output is null");
    }
    return topic.topic;
  }
);

const generateDefinition = genkitAI.defineTool(
  {
    name: "generateDefinition",
    description: "generate definition",
    inputSchema: z.object({
      topic: z.string(),
    }),
    outputSchema: z.object({
      aiTextResponse: z.string(),
      groundings: z.array(GroundingDataSchema),
    }),
  },
  async (input) => {
    console.log(`#generateDefinition: ${JSON.stringify({ input }, null, 2)}`);
    const { aiTextResponse, groundings } = await googleSearchGroundingData(
      `「${input.topic}」。これについて説明してください。「${input.topic}」とは、から始まる文章にしてください`
    );
    return {
      aiTextResponse,
      groundings,
    };
  }
);

// NOTE: Grounding x JSON modeは使用できない
// const options: GenerateOptions = {
//   prompt: `${"結婚に必要なこと"} を達成するために必要なTODOリストを出力してください`,
//   output: { schema: TODOCreateSchemaOutput },
// };
// const response = await genkitAI.generate(options);
// -------------------------------------------
// NOTE: これでgroudingの情報が取得できるが、unknownの型からanyにして取り出しているので大変
// const response = await genkitAI.generate({
//   prompt: `${"結婚に必要なこと"} を達成するために必要なTODOリストを出力してください`,
// });

// const responseCustom = response.custom as any;
// const candidates = responseCustom.candidates;
// const firstCandidate = candidates?.[0];
// const content = firstCandidate?.content;
// const index = firstCandidate?.index;
// const groundingMetadata = firstCandidate?.groundingMetadata;
// const groundingChunks = groundingMetadata?.groundingChunks;
// const web = groundingChunks?.[0].web;
// const title = web?.title;
// const url = web?.uri;
// console.log(JSON.stringify({ index: index }, null, 2));
// console.log(JSON.stringify({ content: content }, null, 2));
// console.log(JSON.stringify({ firstCandidate: firstCandidate }, null, 2));
// console.log(
//   JSON.stringify({ groundingMetadata: groundingMetadata }, null, 2)
// );
// console.log(JSON.stringify({ title: title, url: url }, null, 2));

// const text = response.text;
// console.log(JSON.stringify({ text: text }, null, 2));

// const json = await formatToJSONFromMarkdownAnswer(text);
// console.log(
//   JSON.stringify({ formatToJSONFromMarkdownAnswer: json }, null, 2)
// );

// return json;

export const ResponseSchema = z.union([
  DataResponseSchema.extend({
    data: z.object({
      task: TaskSchema,
    }),
  }),
  ErrorResponseSchema,
]);

// このflowはCloud Taskから使用されるのでエラーハンドリングは慎重に
export const taskCreate = genkitAI.defineFlow(
  {
    name: "taskCreate",
    inputSchema: TaskCreateSchema,
    outputSchema: ResponseSchema,
  },
  async (input) => {
    console.log(`#taskCreate: ${JSON.stringify({ input }, null, 2)}`);
    try {
      const {
        taskID,
        question,
        userRequest: { userID },
      } = input;
      const taskDocRef = database.doc(`/users/${userID}/tasks/${taskID}`);
      const taskDocSnapshot = await taskDocRef.get();
      const taskLoading = taskDocSnapshot.data();
      if (!zodTypeGuard(TaskPreparingSchema, taskLoading)) {
        // TaskPreparingのデータが無い場合は処理を続けることができないので、Retryしない
        return errorResponse(
          new Error(`task loading parse error. taskLoading: ${taskLoading}`)
        );
      }

      if (
        taskLoading.topic == null ||
        taskLoading.definitionAITextResponse == null ||
        taskLoading.definitionGroundings == null
      ) {
        const topic = await extractTopic({ question }).catch((err) => {
          throw new TaskRetryError(`extractTopic failed. ${errorMessage(err)}`);
        });
        const {
          aiTextResponse: definitionAITextResponse,
          groundings: definitionGroundings,
        } = await generateDefinition({ topic }).catch((err) => {
          throw new TaskRetryError(
            `generateDefinition failed. ${errorMessage(err)}`
          );
        });

        const updatedTaskSchema = TaskPreparingSchema.pick({
          topic: true,
          definitionAITextResponse: true,
          definitionGroundings: true,
          serverUpdatedDateTime: true,
        });
        const updatedTask: z.infer<typeof updatedTaskSchema> = {
          topic,
          definitionAITextResponse,
          definitionGroundings,
          serverUpdatedDateTime: Timestamp.now(),
        };
        database
          .doc(`/users/${userID}/tasks/${taskID}`)
          .set(updatedTask, { merge: true });
      }

      if (taskLoading.shortAnswer == null) {
        const shortAnswerResponse = await genkitAI
          .generate({
            prompt: `「${question}」 を短く回答してください`,
          })
          .catch((err) => {
            throw new TaskRetryError(
              `generateShortAnswer failed. ${errorMessage(err)}`
            );
          });
        const shortAnswer = shortAnswerResponse.text;

        const updatedTaskSchema = TaskPreparingSchema.pick({
          shortAnswer: true,
          serverUpdatedDateTime: true,
        });
        const updatedTask: z.infer<typeof updatedTaskSchema> = {
          shortAnswer,
          serverUpdatedDateTime: Timestamp.now(),
        };
        database
          .doc(`/users/${userID}/tasks/${taskID}`)
          .set(updatedTask, { merge: true });
      }

      // NOTE: question, topic が必要なので、queueに詰める作業はその後である必要がある
      if (
        taskLoading.todosGroundings == null ||
        taskLoading.todosGroundings.length === 0 ||
        taskLoading.todosAITextResponseMarkdown == null
      ) {
        // NOTE: [TODOs:Idempotentency] todosGroundings,todosAIResponseMarkdownがnullの場合は、todosがこのタスクの中で正常に作られなかったので一回削除する
        const todosCollectionRef = database.collection(
          `/users/${userID}/tasks/${taskID}/todos`
        );
        const todosDocRefs = await todosCollectionRef.listDocuments();
        for (const docRef of todosDocRefs) {
          await docRef.delete();
        }

        const {
          aiTextResponse: todosAITextResponseMarkdown,
          groundings: todosGroundings,
        } = await googleSearchGroundingData(
          `「${question}」 を達成するために必要なTODOリストを出力してください。markdown形式で出力してください`
        ).catch((err) => {
          throw new TaskRetryError(
            `googleSearchGroundingData failed. ${errorMessage(err)}`
          );
        });
        const todoContents = await todoContentFromMarkdown(
          todosAITextResponseMarkdown
        ).catch((err) => {
          throw new TaskRetryError(
            `todoContentFromMarkdown failed. ${errorMessage(err)}`
          );
        });
        const todos: z.infer<typeof TODOSchema>[] = [];
        for (const { content, supplement } of todoContents) {
          const todoDocRef = database
            .collection(`/users/${userID}/tasks/${taskID}/todos`)
            .doc();

          const todo: TODO = {
            id: todoDocRef.id,
            userID,
            taskID,
            content,
            supplement,
            aiTextResponseMarkdown: null,
            groundings: null,
            locations: null,
            locationsAITextResponse: null,
            locationsGroundings: null,
            serverCreatedDateTime: Timestamp.now(),
            serverUpdatedDateTime: Timestamp.now(),
          };
          todos.push(todo);

          await todoDocRef.set(todo, { merge: true });

          // enqueue先でTODOのdocumentを参照するので先に作成
          await enqueueTODOPrepare({
            taskID,
            todoID: todoDocRef.id,
            question,
            taskTopic: taskLoading.topic ?? "",
            content,
            supplement,
            userRequest: { userID },
          });
        }

        // NOTE: [TODOs:Idempotentency] このスコープの一番上の方でtodosを全消ししている。
        // todosGroundings,todosAIResponseMarkdownがnullの場合は、todosがこのタスクの中で正常に作られなかったと判断して一回削除している
        // なので、todosGroundings,todosAIResponseMarkdownは最後にセットする必要がある
        const updatedTaskSchema = TaskPreparingSchema.pick({
          todosGroundings: true,
          todosAITextResponseMarkdown: true,
          serverUpdatedDateTime: true,
        });
        const updatedTask: z.infer<typeof updatedTaskSchema> = {
          todosGroundings,
          todosAITextResponseMarkdown,
          serverUpdatedDateTime: Timestamp.now(),
        };

        await taskDocRef.set(updatedTask, { merge: true });
      }

      const updateTaskSchema = TaskPreparedSchema.pick({
        status: true,
        preparedDateTime: true,
        completed: true,
        serverUpdatedDateTime: true,
      });
      const updateTask: z.infer<typeof updateTaskSchema> = {
        status: "prepared",
        preparedDateTime: Timestamp.now(),
        completed: false,
        serverUpdatedDateTime: Timestamp.now(),
      };

      const taskSnapshot = await database
        .doc(`/users/${userID}/tasks/${taskID}`)
        .get();
      const task = {
        ...(taskSnapshot.data() ?? {}),
        ...updateTask,
      };
      if (!zodTypeGuard(TaskPreparedSchema, task)) {
        // 用意できなかったプロパティがあると判断するのでRetryする
        functions.logger.info("task not fullfilled", {
          taskLoading,
        });
        throw new Error("task not fullfilled");
      }

      await database
        .doc(`/users/${userID}/tasks/${taskID}`)
        .set(task, { merge: true });

      const response: z.infer<typeof ResponseSchema> = {
        result: "OK",
        statusCode: 200,
        data: {
          task,
        },
      };
      functions.logger.log(`fullfilled: ${JSON.stringify({ task }, null, 2)}`);

      return response;
    } catch (error) {
      if (error instanceof TaskRetryError) {
        throw error;
      }
      return errorResponse(error);
    }
  }
);

// Output example
/*
{
  "candidates": [
    {
      "index": 0,
      "message": {
        "role": "model",
        "content": [
          {
            "text": "結婚に必要なことを達成するためのTODOリストを作成しました。大きく分けて「結婚準備」と「結婚後の手続き」の2つに分けています。\n\n## 結婚準備TODOリスト\n**- 結婚の合意:**\n   * お互いの結婚に対する意思を確認する\n   * 結婚生活について話し合う（生活費、住居、家事分担、将来設計など）\n**- 両家への挨拶:**\n   * それぞれの実家に結婚の意志を伝える\n   * 両家の顔合わせの日程調整\n**- 結婚式・披露宴について:**\n   * 結婚式を挙げるか、または写真だけにするかなどを決める\n   * 結婚式をする場合、日取り、場所、招待客、予算などを決める\n   * 式場探し、衣装選び、招待状作成など、結婚式の準備を進める\n**- 婚約・結婚指輪の準備:**\n   * 婚約指輪、結婚指輪のデザイン、予算などを決めて購入する\n**- 新生活の準備:**\n    * 住居を決める（賃貸or購入、場所、間取りなど） \n    * 家具、家電など、新生活に必要なものを購入する\n    * 引越しの準備\n\n## 結婚後の手続きTODOリスト\n**- 役所への届け出:**\n    * 婚姻届を提出する (住所変更がある場合は、転出届・転入届も必要)\n    * 戸籍簿の変更手続き\n    * 保険証、年金手帳などの名義変更手続き\n**- 会社関係の手続き:**\n    * 会社への結婚報告と、それに伴う手続き（保険、年金など）\n**- その他:**\n   * 銀行口座、クレジットカード、運転免許証などの名義変更\n   * パスポートの名義変更\n   * 公共料金の名義変更\n   * 携帯電話の名義変更\n\n**結婚準備は、順序が前後したり、並行して行う作業も多いです。**余裕を持って、二人で協力しながら進めていきましょう！"
          }
        ]
      },
      "finishReason": "stop",
      "custom": {
        "safetyRatings": [
          {
            "category": "HARM_CATEGORY_HATE_SPEECH",
            "probability": "NEGLIGIBLE",
            "probabilityScore": 0.122558594,
            "severity": "HARM_SEVERITY_NEGLIGIBLE",
            "severityScore": 0.08251953
          },
          {
            "category": "HARM_CATEGORY_DANGEROUS_CONTENT",
            "probability": "NEGLIGIBLE",
            "probabilityScore": 0.11279297,
            "severity": "HARM_SEVERITY_NEGLIGIBLE",
            "severityScore": 0.19042969
          },
          {
            "category": "HARM_CATEGORY_HARASSMENT",
            "probability": "NEGLIGIBLE",
            "probabilityScore": 0.140625,
            "severity": "HARM_SEVERITY_LOW",
            "severityScore": 0.21777344
          },
          {
            "category": "HARM_CATEGORY_SEXUALLY_EXPLICIT",
            "probability": "NEGLIGIBLE",
            "probabilityScore": 0.25976563,
            "severity": "HARM_SEVERITY_NEGLIGIBLE",
            "severityScore": 0.19824219
          }
        ]
      }
    }
  ],
  // NOTE: ここを狙ってcandidates,groundingMetadata,groundingChunksを抽出する
  "custom": {
    "candidates": [
      {
        "content": {
          "role": "model",
          "parts": [
            {
              "text": "結婚に必要なことを達成するためのTODOリストを作成しました。大きく分けて「結婚準備」と「結婚後の手続き」の2つに分けています。\n\n## 結婚準備TODOリスト\n**- 結婚の合意:**\n   * お互いの結婚に対する意思を確認する\n   * 結婚生活について話し合う（生活費、住居、家事分担、将来設計など）\n**- 両家への挨拶:**\n   * それぞれの実家に結婚の意志を伝える\n   * 両家の顔合わせの日程調整\n**- 結婚式・披露宴について:**\n   * 結婚式を挙げるか、または写真だけにするかなどを決める\n   * 結婚式をする場合、日取り、場所、招待客、予算などを決める\n   * 式場探し、衣装選び、招待状作成など、結婚式の準備を進める\n**- 婚約・結婚指輪の準備:**\n   * 婚約指輪、結婚指輪のデザイン、予算などを決めて購入する\n**- 新生活の準備:**\n    * 住居を決める（賃貸or購入、場所、間取りなど） \n    * 家具、家電など、新生活に必要なものを購入する\n    * 引越しの準備\n\n## 結婚後の手続きTODOリスト\n**- 役所への届け出:**\n    * 婚姻届を提出する (住所変更がある場合は、転出届・転入届も必要)\n    * 戸籍簿の変更手続き\n    * 保険証、年金手帳などの名義変更手続き\n**- 会社関係の手続き:**\n    * 会社への結婚報告と、それに伴う手続き（保険、年金など）\n**- その他:**\n   * 銀行口座、クレジットカード、運転免許証などの名義変更\n   * パスポートの名義変更\n   * 公共料金の名義変更\n   * 携帯電話の名義変更\n\n**結婚準備は、順序が前後したり、並行して行う作業も多いです。**余裕を持って、二人で協力しながら進めていきましょう！"
            }
          ]
        },
        "finishReason": "STOP",
        "safetyRatings": [
          {
            "category": "HARM_CATEGORY_HATE_SPEECH",
            "probability": "NEGLIGIBLE",
            "probabilityScore": 0.122558594,
            "severity": "HARM_SEVERITY_NEGLIGIBLE",
            "severityScore": 0.08251953
          },
          {
            "category": "HARM_CATEGORY_DANGEROUS_CONTENT",
            "probability": "NEGLIGIBLE",
            "probabilityScore": 0.11279297,
            "severity": "HARM_SEVERITY_NEGLIGIBLE",
            "severityScore": 0.19042969
          },
          {
            "category": "HARM_CATEGORY_HARASSMENT",
            "probability": "NEGLIGIBLE",
            "probabilityScore": 0.140625,
            "severity": "HARM_SEVERITY_LOW",
            "severityScore": 0.21777344
          },
          {
            "category": "HARM_CATEGORY_SEXUALLY_EXPLICIT",
            "probability": "NEGLIGIBLE",
            "probabilityScore": 0.25976563,
            "severity": "HARM_SEVERITY_NEGLIGIBLE",
            "severityScore": 0.19824219
          }
        ],

        "groundingMetadata": {
          "webSearchQueries": [
            "結婚に必要なこと"
          ],
          "searchEntryPoint": {
            "renderedContent": "<style>\n.container {\n  align-items: center;\n  border-radius: 8px;\n  display: flex;\n  font-family: Google Sans, Roboto, sans-serif;\n  font-size: 14px;\n  line-height: 20px;\n  padding: 8px 12px;\n}\n.chip {\n  display: inline-block;\n  border: solid 1px;\n  border-radius: 16px;\n  min-width: 14px;\n  padding: 5px 16px;\n  text-align: center;\n  user-select: none;\n  margin: 0 8px;\n  -webkit-tap-highlight-color: transparent;\n}\n.carousel {\n  overflow: auto;\n  scrollbar-width: none;\n  white-space: nowrap;\n  margin-right: -12px;\n}\n.headline {\n  display: flex;\n  margin-right: 4px;\n}\n.gradient-container {\n  position: relative;\n}\n.gradient {\n  position: absolute;\n  transform: translate(3px, -9px);\n  height: 36px;\n  width: 9px;\n}\n@media (prefers-color-scheme: light) {\n  .container {\n    background-color: #fafafa;\n    box-shadow: 0 0 0 1px #0000000f;\n  }\n  .headline-label {\n    color: #1f1f1f;\n  }\n  .chip {\n    background-color: #ffffff;\n    border-color: #d2d2d2;\n    color: #5e5e5e;\n    text-decoration: none;\n  }\n  .chip:hover {\n    background-color: #f2f2f2;\n  }\n  .chip:focus {\n    background-color: #f2f2f2;\n  }\n  .chip:active {\n    background-color: #d8d8d8;\n    border-color: #b6b6b6;\n  }\n  .logo-dark {\n    display: none;\n  }\n  .gradient {\n    background: linear-gradient(90deg, #fafafa 15%, #fafafa00 100%);\n  }\n}\n@media (prefers-color-scheme: dark) {\n  .container {\n    background-color: #1f1f1f;\n    box-shadow: 0 0 0 1px #ffffff26;\n  }\n  .headline-label {\n    color: #fff;\n  }\n  .chip {\n    background-color: #2c2c2c;\n    border-color: #3c4043;\n    color: #fff;\n    text-decoration: none;\n  }\n  .chip:hover {\n    background-color: #353536;\n  }\n  .chip:focus {\n    background-color: #353536;\n  }\n  .chip:active {\n    background-color: #464849;\n    border-color: #53575b;\n  }\n  .logo-light {\n    display: none;\n  }\n  .gradient {\n    background: linear-gradient(90deg, #1f1f1f 15%, #1f1f1f00 100%);\n  }\n}\n</style>\n<div class=\"container\">\n  <div class=\"headline\">\n    <svg class=\"logo-light\" width=\"18\" height=\"18\" viewBox=\"9 9 35 35\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\">\n      <path fill-rule=\"evenodd\" clip-rule=\"evenodd\" d=\"M42.8622 27.0064C42.8622 25.7839 42.7525 24.6084 42.5487 23.4799H26.3109V30.1568H35.5897C35.1821 32.3041 33.9596 34.1222 32.1258 35.3448V39.6864H37.7213C40.9814 36.677 42.8622 32.2571 42.8622 27.0064V27.0064Z\" fill=\"#4285F4\"/>\n      <path fill-rule=\"evenodd\" clip-rule=\"evenodd\" d=\"M26.3109 43.8555C30.9659 43.8555 34.8687 42.3195 37.7213 39.6863L32.1258 35.3447C30.5898 36.3792 28.6306 37.0061 26.3109 37.0061C21.8282 37.0061 18.0195 33.9811 16.6559 29.906H10.9194V34.3573C13.7563 39.9841 19.5712 43.8555 26.3109 43.8555V43.8555Z\" fill=\"#34A853\"/>\n      <path fill-rule=\"evenodd\" clip-rule=\"evenodd\" d=\"M16.6559 29.8904C16.3111 28.8559 16.1074 27.7588 16.1074 26.6146C16.1074 25.4704 16.3111 24.3733 16.6559 23.3388V18.8875H10.9194C9.74388 21.2072 9.06992 23.8247 9.06992 26.6146C9.06992 29.4045 9.74388 32.022 10.9194 34.3417L15.3864 30.8621L16.6559 29.8904V29.8904Z\" fill=\"#FBBC05\"/>\n      <path fill-rule=\"evenodd\" clip-rule=\"evenodd\" d=\"M26.3109 16.2386C28.85 16.2386 31.107 17.1164 32.9095 18.8091L37.8466 13.8719C34.853 11.082 30.9659 9.3736 26.3109 9.3736C19.5712 9.3736 13.7563 13.245 10.9194 18.8875L16.6559 23.3388C18.0195 19.2636 21.8282 16.2386 26.3109 16.2386V16.2386Z\" fill=\"#EA4335\"/>\n    </svg>\n    <svg class=\"logo-dark\" width=\"18\" height=\"18\" viewBox=\"0 0 48 48\" xmlns=\"http://www.w3.org/2000/svg\">\n      <circle cx=\"24\" cy=\"23\" fill=\"#FFF\" r=\"22\"/>\n      <path d=\"M33.76 34.26c2.75-2.56 4.49-6.37 4.49-11.26 0-.89-.08-1.84-.29-3H24.01v5.99h8.03c-.4 2.02-1.5 3.56-3.07 4.56v.75l3.91 2.97h.88z\" fill=\"#4285F4\"/>\n      <path d=\"M15.58 25.77A8.845 8.845 0 0 0 24 31.86c1.92 0 3.62-.46 4.97-1.31l4.79 3.71C31.14 36.7 27.65 38 24 38c-5.93 0-11.01-3.4-13.45-8.36l.17-1.01 4.06-2.85h.8z\" fill=\"#34A853\"/>\n      <path d=\"M15.59 20.21a8.864 8.864 0 0 0 0 5.58l-5.03 3.86c-.98-2-1.53-4.25-1.53-6.64 0-2.39.55-4.64 1.53-6.64l1-.22 3.81 2.98.22 1.08z\" fill=\"#FBBC05\"/>\n      <path d=\"M24 14.14c2.11 0 4.02.75 5.52 1.98l4.36-4.36C31.22 9.43 27.81 8 24 8c-5.93 0-11.01 3.4-13.45 8.36l5.03 3.85A8.86 8.86 0 0 1 24 14.14z\" fill=\"#EA4335\"/>\n    </svg>\n    <div class=\"gradient-container\"><div class=\"gradient\"></div></div>\n  </div>\n  <div class=\"carousel\">\n    <a class=\"chip\" href=\"https://vertexaisearch.cloud.google.com/grounding-api-redirect/AUBnsYtZVB9TcVk2FIbvXoNqrAm2PBsiQ9krjdBKCNhQ5xkxoNkcVBcd4ScTG8AdFGb_f0tyY9xdJ5J9ktmW6otWANLdgFH5asIwjYnM3-UyvYQZ2_zsr8rNve8Ijv6LzXhpp0F0zlUTWwluitkfYfG9WCOLI-fJpjdTVZQiWfElu1Nbpyy2G6WifbhrD65hwyS_dCOEoSfjqa1ORaliONYRrFvh9pSHluZJXm69tUB1yOfyE9bSYjzvHWL6u0PHz_EjTVTmv8ogwUiEGj9CTFk=\">結婚に必要なこと</a>\n  </div>\n</div>\n"
          },
          "groundingChunks": [
            {
              "web": {
                "uri": "https://vertexaisearch.cloud.google.com/grounding-api-redirect/AUBnsYvYuKixRywsN77Qh5BZS-yby2PO2juncml__Wi338DKBaYJBY0E5AqeUaHCE4i8qJGHhMHFF9zWY1SMYD89DWvQoDkqsaO-VwKmCbClcrvoBIYAKdrqQzvyusVWixSOx4MSSVyysbc=",
                "title": "zexy.net"
              }
            }
          ],
          "groundingSupports": [
            {
              "segment": {
                "startIndex": 1219,
                "endIndex": 1311,
                "text": "* 婚姻届を提出する (住所変更がある場合は、転出届・転入届も必要)"
              },
              "groundingChunkIndices": [
                0
              ],
              "confidenceScores": [
                0.6840233
              ]
            }
          ],
          "retrievalMetadata": {}
        },
        "avgLogprobs": -0.18312162511488972,
        "index": 0
      }
    ],
    "usageMetadata": {
      "promptTokenCount": 12,
      "candidatesTokenCount": 425,
      "totalTokenCount": 437,
      "promptTokensDetails": [
        {
          "modality": "TEXT",
          "tokenCount": 12
        }
      ],
      "candidatesTokensDetails": [
        {
          "modality": "TEXT",
          "tokenCount": 425
        }
      ]
    },
    "modelVersion": "gemini-1.5-pro-001",
    "createTime": "2025-01-31T04:54:22.967883Z",
    "responseId": "flecZ8uJO8eCidsP1eCtyQE"
  },
  "usage": {
    "inputCharacters": 36,
    "inputImages": 0,
    "inputVideos": 0,
    "inputAudioFiles": 0,
    "outputCharacters": 780,
    "outputImages": 0,
    "outputVideos": 0,
    "outputAudioFiles": 0,
    "inputTokens": 12,
    "outputTokens": 425,
    "totalTokens": 437
  },
  "latencyMs": 14659.904333
}
*/
