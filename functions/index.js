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
   .document('bookings_notification/{booking_status}')
   .onUpdate((snapshot, context) => {
//       console.log(snapshot.data());
//       if (snapshot.data().booking_status === "upcoming"){
        const values = snapshot.after.data();
        const previous = snapshot.before.data();
        if (previous.booking_status !== "incomplete")
        return admin.messaging().sendToTopic("bookings",{notification:{
              title:snapshot.data().user_name,
              body:"Booking is successful",
              clickAction:'FLUTTER_NOTIFICATION_CLICK'
              }});
//       }else{
//       return;
//       }

    });
