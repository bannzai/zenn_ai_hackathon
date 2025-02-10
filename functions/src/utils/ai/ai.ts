import { genkit, z } from "genkit";
import { vertexAI } from "@genkit-ai/vertexai";
import { gemini15Pro } from "@genkit-ai/vertexai";
import {
  GenerateContentResult,
  GenerativeModel,
  GoogleGenerativeAI,
  GroundingChunk,
  Tool,
} from "@google/generative-ai";
import { GroundingData, GroundingDataSchema } from "../../entity/grounding";
import { errorMessage } from "../error/message";

export const genkitAI = genkit({
  model: gemini15Pro.withConfig({ googleSearchRetrieval: {} }),
  // NOT WORKING: genkitはgoogleSearchが使えない
  // model: gemini20FlashExp.withConfig({ googleSearch: {} } as any),
  plugins: [vertexAI()],
});

export const googleGenerativeAI = new GoogleGenerativeAI(
  // eslint-disable-next-line @typescript-eslint/no-non-null-assertion
  process.env.GOOGLE_GENAI_API_KEY!
);

// Unable to submit request because Please use google_search field instead of google_search_retrieval field.. Learn more: https://cloud.google.com/vertex-ai/generative-ai/docs/model-reference/gemini
// gemini-2.0-flash-exp では google_search_retrieval が使えない googleSearch を無理やり渡せば使える
// なお、今の所コスト面以外では gemini-1.5-flashにして googleSearchRetrival を使っても問題はない
// https://stackoverflow.com/questions/79289711/grounding-with-google-search-with-gemini-2-0-flash-exp
const googleSearchTool = {
  googleSearch: {},
} as Tool;

const googleSearchRetrievalTool: Tool = {
  googleSearchRetrieval: {},
};

function googleSearchModel15Flash(): GenerativeModel {
  return googleGenerativeAI.getGenerativeModel({
    model: "gemini-1.5-flash",
    tools: [googleSearchRetrievalTool],
  });
}

function googleSearchModel20FlashExp(): GenerativeModel {
  return googleGenerativeAI.getGenerativeModel({
    model: "gemini-2.0-flash-exp",
    tools: [
      googleSearchTool,
      // NOTE: functionTool を使って整形を直接行えない
      // functionTool,
      // {
      //   googleSearchRetrieval: {
      //     dynamicRetrievalConfig: {
      //       // mode: DynamicRetrievalMode.MODE_DYNAMIC,
      //       // dynamicThreshold: 0.5,
      //     },
      //   },
      // },
    ],
  });
}
const GroundingSchema = z.object({
  aiTextResponse: z.string(),
  groundings: z.array(GroundingDataSchema),
});
type Grounding = z.infer<typeof GroundingSchema>;

export async function googleSearchGroundingData(
  query: string
): Promise<Grounding> {
  console.log(
    `#googleSearchGroundingData: ${JSON.stringify({ query }, null, 2)}`
  );
  const returnErrors: any[] = [];

  // NOTE: googleSearchGroundingData15FlashResult_1 が一番結果が返ってきやすい
  let googleSearchGroundingData15FlashResult_1: Grounding | null = null;
  try {
    const model = googleSearchModel15Flash();
    const result = await model.generateContent(query);
    googleSearchGroundingData15FlashResult_1 = transformGroundingData(result);
    console.log(JSON.stringify({ googleSearchGroundingData15FlashResult_1 }));
  } catch (error) {
    console.error(error);
    returnErrors.push(
      `googleSearchGroundingData15FlashResult_1: ${errorMessage(error)}`
    );
  }
  if (
    googleSearchGroundingData15FlashResult_1 &&
    groundingHasTitleAndURL(googleSearchGroundingData15FlashResult_1)
  ) {
    return googleSearchGroundingData15FlashResult_1;
  }
  let googleSearchGroundingData20FlashExp_1Result: Grounding | null = null;

  try {
    const model = googleSearchModel20FlashExp();
    const result = await model.generateContent({
      contents: [{ role: "user", parts: [{ text: query }] }],
      tools: [googleSearchTool],
    });
    googleSearchGroundingData20FlashExp_1Result =
      transformGroundingData(result);
    console.log(
      JSON.stringify({ googleSearchGroundingData20FlashExp_1Result })
    );
  } catch (error) {
    console.error(error);

    returnErrors.push(
      `googleSearchGroundingData20FlashExp_1Result: ${errorMessage(error)}`
    );
  }
  if (
    googleSearchGroundingData20FlashExp_1Result &&
    groundingHasTitleAndURL(googleSearchGroundingData20FlashExp_1Result)
  ) {
    return googleSearchGroundingData20FlashExp_1Result;
  }

  let googleSearchGroundingData20FlashExp_2Result: Grounding | null = null;
  try {
    const model = googleSearchModel20FlashExp();
    const result = await model.generateContent(query);
    googleSearchGroundingData20FlashExp_2Result =
      transformGroundingData(result);
    console.log(
      JSON.stringify({ googleSearchGroundingData20FlashExp_2Result })
    );
  } catch (error) {
    console.error(error);
    returnErrors.push(
      `googleSearchGroundingData20FlashExp_2Result: ${errorMessage(error)}`
    );
  }
  if (
    googleSearchGroundingData20FlashExp_2Result &&
    groundingHasTitleAndURL(googleSearchGroundingData20FlashExp_2Result)
  ) {
    return googleSearchGroundingData20FlashExp_2Result;
  }

  let googleSearchGroundingData15FlashResult_2: Grounding | null = null;
  try {
    const model = googleSearchModel15Flash();
    const result = await model.generateContent({
      contents: [{ role: "user", parts: [{ text: query }] }],
      tools: [googleSearchRetrievalTool],
    });
    googleSearchGroundingData15FlashResult_2 = transformGroundingData(result);
    console.log(JSON.stringify({ googleSearchGroundingData15FlashResult_2 }));
  } catch (error) {
    console.error(error);
    returnErrors.push(
      `googleSearchGroundingData15FlashResult_2: ${errorMessage(error)}`
    );
  }
  if (
    googleSearchGroundingData15FlashResult_2 &&
    groundingHasTitleAndURL(googleSearchGroundingData15FlashResult_2)
  ) {
    return googleSearchGroundingData15FlashResult_2;
  }

  const bestGrounding = bestScoreGrounding(
    googleSearchGroundingData20FlashExp_1Result,
    googleSearchGroundingData20FlashExp_2Result,
    googleSearchGroundingData15FlashResult_1,
    googleSearchGroundingData15FlashResult_2
  );
  if (bestGrounding) {
    return bestGrounding;
  }

  throw new Error(
    "Failed to get google search grounding data. " + returnErrors.join(", ")
  );
}

function transformGroundingData(result: GenerateContentResult): {
  aiTextResponse: string;
  groundings: GroundingData[];
} {
  const response = result.response;
  const candidates = response?.candidates;
  const groundings: GroundingData[] = [];
  if (candidates) {
    for (const candidate of candidates) {
      const groudingMetadata = candidate?.groundingMetadata;
      const index = candidate?.index;
      const anyGroudingMetadata = groudingMetadata as any;
      // typo: https://github.com/google-gemini/generative-ai-js/issues/323
      const groundingChunks = anyGroudingMetadata[
        "groundingChunks"
      ] as GroundingChunk[];
      const web = groundingChunks?.[0].web;
      const title = web?.title;
      const url = web?.uri;
      // console.log(JSON.stringify({ groundingChunks: groundingChunks }));
      // console.log(JSON.stringify({ web: web }, null, 2));
      // console.log(JSON.stringify({ title: title }, null, 2));
      // console.log(JSON.stringify({ url: url }, null, 2));
      groundings.push({ title, url, index });
    }
  }
  return { aiTextResponse: response?.text() ?? "", groundings };
}

function groundingHasTitleAndURL(grounding: Grounding): boolean {
  let hasTitleAndURL = false;
  for (const _grounding of grounding.groundings) {
    if (_grounding.title && _grounding.url) {
      hasTitleAndURL = true;
    }
  }
  return hasTitleAndURL;
}

function groundingScore(grounding: Grounding): number {
  let score = grounding.groundings.length * 2;
  for (const _grounding of grounding.groundings) {
    if (!_grounding.title) {
      score -= 1;
    }
    if (!_grounding.url) {
      score -= 1;
    }
  }
  return score;
}

function bestScoreGrounding(
  ...groundings: (Grounding | null)[]
): Grounding | null {
  return groundings.reduce((best, current) => {
    if (!best) {
      return current;
    }
    if (!current) {
      return best;
    }
    return groundingScore(best) > groundingScore(current) ? best : current;
  });
}
