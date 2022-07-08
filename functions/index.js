/* eslint-disable */
const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
 exports.myFunction = functions.firestore
   .document('push_notifications/{id}')
   .onCreate(  (snapshot, context) => {
   console.log(snapshot.data().id);

    const payload = {
         notification:{
           title: String(snapshot.data().title),
           body:String(snapshot.data().definition),
           clickAction:'FLUTTER_NOTIFICATION_CLICK',
        },
       data: {
                      title: "Cloud Messaging",
                      message: "Open the app right now, please.",
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

    //             var payload;
    //            if(snapshot.data().status == "upcoming"){
    //              const  payload = {
    //                                  notification:{
    //                                    title:"Booking successful for " + String(snapshot.data().vendor_name),
    //                                    body: "Share OTP at the center to start.",
    //                                    clickAction:'FLUTTER_NOTIFICATION_CLICK',
    //                                 }
    //                            };
    //                            return admin.messaging().sendToDevice(snapshot1.data().device_token,payload);
    //            }
                if(snapshot.data().status == "active"){
                       const  payload = {
                                           notification:{
                                             title:"Booking activated " + String(snapshot.data().user_name),
                                              body: "Stay hydrated.🚰",
                                              clickAction:'FLUTTER_NOTIFICATION_CLICK',
                                                 }
                                            };
                                            return admin.messaging().sendToDevice(snapshot1.data().device_token,payload);
                }
                   if(snapshot.data().status == "completed"){
                                   const  payload = {
                                                       notification:{
                                                         title:"Booking completed " + String(snapshot.data().user_name),
                                                          body: "Eat well & take some rest 😇",
                                                          clickAction:'FLUTTER_NOTIFICATION_CLICK',
                                                             }
                                                        };
                                                        return admin.messaging().sendToDevice(snapshot1.data().device_token,payload);
                            }


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
    //  var payload1;
        if(snapshot.data().status == "upcoming"){
         const payload1 = {
                           notification:{
                            title: "New booking received!",
                               body: "Enter OTP to activate ✅",
                         clickAction:'FLUTTER_NOTIFICATION_CLICK',
                                     }
                                };
                return admin.messaging().sendToDevice(tokens,payload1);
        }
            if(snapshot.data().status == "cancelled")     {
             payload1 = {
                               notification:{
                                title: "Booking cancelled by user. ❌",

                               clickAction:'FLUTTER_NOTIFICATION_CLICK',
                                             }
                                        };
        return admin.messaging().sendToDevice(tokens,payload1);
            }


                   }
                   });


            });
 exports.myFunction3 = functions.firestore
   .document('personalised_notification/{id}')
   .onCreate(  (snapshot, context) => {
   console.log(snapshot.data().id);
       admin.firestore().collection("user_details").doc(snapshot.data().user_id).get().then((snapshot1) =>{

           if (snapshot1.empty){
           console.log("no device found");
           }else{
              console.log("device found");
             console.log(snapshot1.data().name);

             const payload = {
                     notification:{
                       title: "Hi" + String(snapshot1.data().name) + String(snapshot.data().title),
                       body:String(snapshot.data().definition),
                       clickAction:'FLUTTER_NOTIFICATION_CLICK',
                    },
                   data: {
                                  title: "Cloud Messaging",
                                  message: "Open the app right now, please.",
                              }
               };
                    return admin.messaging().sendToTopic('personalised_notification',payload);



           }
           });

    });