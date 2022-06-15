/* eslint-disable */
const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();


 exports.myFunction = functions.firestore
   .document('push_notifications/{id}')
   .onCreate((snapshot, context) => {
   console.log(snapshot.data().title);
   const k= snapshot.data()
        return admin.messaging().sendToTopic('push_notifications',{
        notification:{
              title:String(k.title),
              body:String(k.definition),
              clickAction:'FLUTTER_NOTIFICATION_CLICK',
              },
              }
              );


    });
