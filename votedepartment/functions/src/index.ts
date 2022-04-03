import * as functions from "firebase-functions";
import admin = require("firebase-admin");
admin.initializeApp();

const firestore = admin.firestore();
const settings = {timestampsInSnapshots: true};
firestore.settings(settings);

exports.Signup = functions.https.onCall(async (data) => {
  return admin
      .auth()
      .setCustomUserClaims(data.uid, {
        admin: false,
        isValidator: true,
      })
      .then(async () => {
        await firestore.collection("Validators").doc(data.uid).set({
          createdAt: admin.firestore.FieldValue.serverTimestamp(),
          catId: data.id,
        });
      })
      .catch((error) => {
        console.log(error);
      });
});
