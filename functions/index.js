/* eslint-disable */
const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();


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
