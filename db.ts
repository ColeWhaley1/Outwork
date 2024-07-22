import fs from 'fs';
import path from 'path';
import admin from "firebase-admin";

let serviceAccountPath: string;
if (process.env.SERVICE_ACCOUNT_KEY_PATH) {
  serviceAccountPath = process.env.SERVICE_ACCOUNT_KEY_PATH;
} else {
  throw new Error('Service account path is null or undefined.');
}

let serviceAccount = require(serviceAccountPath);

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

const db: FirebaseFirestore.Firestore = admin.firestore();

export default db;

