// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:shocase/Models/user.dart';
//
// class FirestoreService {
//   final CollectionReference _usersCollectionReference = FirebaseFirestore.instance.collection("users");
//
//   Future getUser(String uid) async {
//     try {
//       var userData = await _usersCollectionReference.doc(uid).get();
//       return User.fromData(userData.data);
//     } catch (e) {
//       return e.message;
//     }
//   }
//
// }