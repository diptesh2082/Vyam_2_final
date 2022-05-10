// import 'package:flutter/widgets.dart';
//
// class Upcoming {
//   final String bookindID;
//   final String gymName;
//   final String location;
//   final String bookingPeriod;
//   final String date;
//   final String eventType;
//   final gymImage;
//
//   Upcoming({
//     required this.bookindID,
//     required this.gymName,
//     required this.location,
//     required this.bookingPeriod,
//     required this.date,
//     required this.eventType,
//     required this.gymImage,
//   });
// }
//
// class Active {
//   final String bookindID;
//   final String gymName;
//   final String location;
//   final String bookingPeriod;
//   final String date;
//   final String eventType;
//   final String otp;
//   final String number;
//   final String startDate;
//   final String endDate;
//   final int amount;
//   final int discount;
//   final int promocode;
//   final gymImage;
//
//   Active({
//     required this.bookindID,
//     required this.gymName,
//     required this.location,
//     required this.bookingPeriod,
//     required this.date,
//     required this.eventType,
//     required this.gymImage,
//     required this.amount,
//     required this.discount,
//     required this.endDate,
//     required this.number,
//     required this.otp,
//     required this.startDate,
//     required this.promocode,
//   });
// }
//
// class Older {
//   final String bookindID;
//   final String gymName;
//   final String location;
//   final String bookingPeriod;
//   final String date;
//   final String eventType;
//   final String otp;
//   final String number;
//   final String startDate;
//   final String endDate;
//   final int amount;
//   final int discount;
//   final int promocode;
//   final gymImage;
//   final String rating;
//
//   Older({
//     required this.bookindID,
//     required this.gymName,
//     required this.location,
//     required this.bookingPeriod,
//     required this.date,
//     required this.eventType,
//     required this.gymImage,
//     required this.amount,
//     required this.discount,
//     required this.endDate,
//     required this.number,
//     required this.otp,
//     required this.startDate,
//     required this.promocode,
//     required this.rating,
//   });
// }
//
// class NoticationList {
//   final String notiTitle;
//   final String detail;
//   final String type;
//   NoticationList({
//     required this.notiTitle,
//     required this.detail,
//     required this.type,
//   });
// }
//
// List<NoticationList> notificationList = [
//   NoticationList(
//       notiTitle: "Upto 50% off on first booking",
//       detail: "Use code VYAM2022",
//       type: 'Coupon'),
//   NoticationList(
//       notiTitle: "Upcoming booking with Transformers",
//       detail: "Monday 6.00AM",
//       type: 'None'),
//   NoticationList(
//       notiTitle: "Services inturepted due to lockdown",
//       detail: "Stay safe, Stay in home",
//       type: 'None'),
//   NoticationList(
//       notiTitle: "Share your experince with transformers  ",
//       detail: "Write a review",
//       type: 'None'),
// ];
//
// List<Upcoming> upcomingItems = [
//   Upcoming(
//       bookindID: "00123",
//       gymName: "Nalipara gym",
//       location: "Barakar",
//       bookingPeriod: "Pay per session",
//       date: "02 Feb, 2022",
//       eventType: "Upcoming",
//       gymImage: Image.asset("assets/icons/Bookings-unsplash_CQfNt66ttZM.png")),
//   Upcoming(
//       bookindID: "0043",
//       gymName: "GymX Studios",
//       location: "Asansol",
//       bookingPeriod: "3 Months",
//       date: "6th May",
//       eventType: "Upcoming",
//       gymImage: Image.asset("assets/icons/Bookings-unsplash_20jX9b35r_M.png")),
// ];
//
// List<Active> activeEventItems = [
//   Active(
//       bookindID: "0043",
//       gymName: "Nalipara gym",
//       location: "Barakar",
//       bookingPeriod: "Pay per session",
//       date: "6 May, 2022",
//       eventType: "Active",
//       gymImage: Image.asset(
//         "assets/icons/Bookings-unsplash_CQfNt66ttZM.png",
//       ),
//       amount: 100,
//       discount: 0,
//       endDate: 'May 11, 2022',
//       number: '',
//       otp: '7234',
//       promocode: 0,
//       startDate: 'Feb 11, 2022'),
//   Active(
//       bookindID: "00123",
//       gymName: "GymX Studios",
//       location: "Asansol",
//       bookingPeriod: "3 Months",
//       date: "6th May",
//       eventType: "Active",
//       gymImage: Image.asset("assets/icons/Bookings-unsplash_20jX9b35r_M.png"),
//       amount: 100,
//       discount: 0,
//       endDate: 'May 11, 2022',
//       number: '',
//       otp: '7234',
//       promocode: 0,
//       startDate: 'Feb 11, 2022'),
// ];
//
// List<Older> olderEventItems = [
//   Older(
//       bookindID: "0154",
//       gymName: "GymX Studios",
//       location: "Asansol",
//       bookingPeriod: "6 Months",
//       date: "02 Feb, 2022",
//       eventType: "Completed",
//       gymImage: Image.asset("assets/icons/Bookings-unsplash_20jX9b35r_M.png"),
//       amount: 250,
//       discount: 0,
//       endDate: 'Sept 11, 2022',
//       number: '',
//       otp: '7234',
//       promocode: 0,
//       startDate: 'March 11, 2022',
//       rating: '5.0'),
// ];
