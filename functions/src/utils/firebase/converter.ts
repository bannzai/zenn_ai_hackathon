import * as admin from "firebase-admin";
import { z } from "zod";

// Usage:
/*
const relatedArticlesCollection = await firestore()
  .collectionGroup("articles")
  .where(
    "symbolicKeywords",
    "array-contains-any",
    article.symbolicKeywords
  )
  .withConverter(firestoreConverter(ArticleSchema))
  .get();
*/
export const firestoreConverter = <T extends z.AnyZodObject>(
  schema: T
): admin.firestore.FirestoreDataConverter<z.infer<T>> => ({
  toFirestore: (data: z.infer<T>): admin.firestore.DocumentData => {
    return schema.parse(data);
  },
  fromFirestore: (
    snapshot: admin.firestore.QueryDocumentSnapshot<z.infer<T>>
  ): z.infer<T> => {
    return schema.parse(snapshot.data());
  },
});
