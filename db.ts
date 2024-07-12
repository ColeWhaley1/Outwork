require('dotenv').config();
import admin from "firebase-admin";

let serviceAccount: string;
if(typeof process.env.SERVICE_ACCOUNT_KEY_PATH === 'string'){
  serviceAccount = require(process.env.SERVICE_ACCOUNT_KEY_PATH);
} else {
  throw new Error('Service account path undefined');
}


admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

const db = admin.firestore();

export default db;
