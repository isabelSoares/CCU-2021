// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';

// class PushNotificationsManager {
//   PushNotificationsManager._();

//   factory PushNotificationsManager() => _instance;

//   static final PushNotificationsManager _instance =
//       PushNotificationsManager._();

//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
//   final databaseReference = FirebaseDatabase.instance.reference();

//   bool _initialized = false;

//   Future<void> init() async {
//     if (!_initialized) {
//       _firebaseMessaging.configure(
//           onMessage: (Map<String, dynamic> notification) async {
//         print(notification.toString());
//         DatabaseReference itemRef =
//             databaseReference.child("notifications/received").push();
//         itemRef.set({
//           "type": notification["notification"]["type"],
//           "name": notification["notification"]["name"],
//           "description": notification["notification"]["description"],
//         });
//       }, onLaunch: (Map<String, dynamic> notification) async {
//         print(notification.toString());
//         DatabaseReference itemRef =
//             databaseReference.child("notifications/received").push();
//         itemRef.set({
//           "type": notification["notification"]["type"],
//           "name": notification["notification"]["name"],
//           "description": notification["notification"]["description"],
//         });
//       }, onResume: (Map<String, dynamic> notification) async {
//         print(notification.toString());
//         DatabaseReference itemRef =
//             databaseReference.child("notifications/received").push();
//         itemRef.set({
//           "type": notification["notification"]["type"],
//           "name": notification["notification"]["name"],
//           "description": notification["notification"]["description"],
//         });
//       });

//       _firebaseMessaging.requestNotificationPermissions();

//       String token = await _firebaseMessaging.getToken();
//       print("FirebaseMessaging token: $token");

//       _initialized = true;
//     }
//   }
// }
