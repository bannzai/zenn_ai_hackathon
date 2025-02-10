import admin = require("firebase-admin");

export const database = admin.firestore();
database.settings({ ignoreUndefinedProperties: true });

export const auth = admin.auth();
