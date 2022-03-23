import * as functions from "firebase-functions";
import admin = require("firebase-admin");
admin.initializeApp();

const firestore = admin.firestore();
const settings = {timestampsInSnapshots: true};
firestore.settings(settings);

exports.Signup = functions.https.onCall(async (data) => {
  return admin
      .auth()
      .setCustomUserClaims(data, {
        admin: false,
        isValidator: true,
      })
      .then(async () => {
        await firestore.collection("Validators").doc(data).set({
          createdAt: admin.firestore.FieldValue.serverTimestamp(),
        });
      })
      .catch((error) => {
        console.log(error);
      });
});
