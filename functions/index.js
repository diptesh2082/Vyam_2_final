/* eslint-disable */
const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();


 exports.myFunction = functions.firestore
   .document('push_notifications/{id}')
   .onCreate(  (snapshot, context) => {
   console.log(snapshot.data().id);

    const payload = {
         notification:{
           title: String(snapshot.data().title),
           body:String(snapshot.data().definition),
           clickAction:'FLUTTER_NOTIFICATION_CLICK',
        }
   };
        return admin.messaging().sendToTopic('push_notifications',payload);


    });
     exports.myFunction2 = functions.firestore
       .document('booking_notifications/{id}')
       .onCreate(  (snapshot, context) => {
       console.log(snapshot.data().user_id);
       admin.firestore().collection("user_details").doc(snapshot.data().user_id).get().then((snapshot1) =>{

       if (snapshot1.empty){
       console.log("no device found");
       }else{
          console.log(" device found");
         console.log(snapshot1.data().name);
//         token=snapshot1.data().device_token;
          const payload = {
                      notification:{
                        title: String(snapshot1.data().name),
                        body: "Your booking" + String(snapshot.data().title),
                        clickAction:'FLUTTER_NOTIFICATION_CLICK',
                     }
                };
          return admin.messaging().sendToDevice(snapshot1.data().device_token,payload);

       }
       });

       admin.firestore().collection("product_details").doc(snapshot.data().vendor_id).get().then((snapshot2) =>{
               var tokens=[];
               if (snapshot2.empty){
               console.log("no device found");
               }else{
                  console.log(" device found");
//                 console.log(snapshot2.data().name);
                 tokens=snapshot2.data().token;
//                 console.log(tokens);
                  const payload1 = {
                              notification:{
                                title: String(snapshot2.data().name),
                                body: "vendor" + String(snapshot.data().title),
                                clickAction:'FLUTTER_NOTIFICATION_CLICK',
                             }
                        };
                  return admin.messaging().sendToDevice(tokens,payload1);

               }
               });


        });

