/* eslint-disable */
const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();


 exports.myFunction = functions.firestore
   .document('push_notifications/{id}')
   .onCreate(  (snapshot, context) => {
   console.log(snapshot.data());
   const k= snapshot.data().get();
    const payload = {
         notification:{
           title: String(k.title),
           body:String(k.definition),
           clickAction:'FLUTTER_NOTIFICATION_CLICK',
        }
   };
        return admin.messaging().sendToTopic('push_notifications',payload);


    });
