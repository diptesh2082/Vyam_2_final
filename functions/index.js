/* eslint-disable */
const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();


 exports.myFunction = functions.firestore
   .document('push_notifications/{id}')
   .onCreate(  (snapshot, context) => {
   console.log(snapshot.data().id);
//   const k= admin.firestore().document("push_notifications/${snapshot.data().id}").get();
    const payload = {
         notification:{
           title: String(snapshot.data().title),
           body:String(snapshot.data().definition),
           clickAction:'FLUTTER_NOTIFICATION_CLICK',
        }
   };
        return admin.messaging().sendToTopic('push_notifications',payload);


    });
