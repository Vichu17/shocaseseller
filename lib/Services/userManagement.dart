import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shocase/Providers/auth.dart';
import 'package:shocase/subpages/emailVerification.dart';

class UserManagement with ChangeNotifier{
  final CollectionReference _usersCollectionReference =
      FirebaseFirestore.instance.collection("user_master");
  final _auth = FirebaseAuth.instance;

  Future storeNewUser(context, email, username, phone, user_id, avatar_url) async {
    _usersCollectionReference.doc(user_id).set({
      'user_email': email,
      'user_name': username,
      'user_id': user_id,
      'user_mobile': phone,
      'avatar_url': avatar_url,
    }).then((value) async {
      // Navigator.of(context).pop();
      // Navigator.of(context).pushReplacementNamed('/selectpic');
      Navigator.pushReplacementNamed(context, VerifyScreen.routeName);
      await Provider.of<Auth>(context, listen: false).signup();
      notifyListeners();
    }).catchError((e) {
      print(e);
    });
  }

  Future updateProfilePic(picUrl) async {
    // var userInfo = FirebaseAuth.instance.currentUser!;
    // userInfo.photoUrl = picUrl;

    await FirebaseAuth.instance.currentUser!
        .updateProfile(photoURL: picUrl)
        .then((val) {
      // FirebaseAuth.instance.currentUser!.then((user) {
      FirebaseFirestore.instance
          .collection('/user_master')
          .where('user_id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((docs) {
        FirebaseFirestore.instance
            .doc('/user_master/${docs.docs[0].id}')
            .update({'avatar_url': picUrl}).then((val) {
          print('Updated');
          notifyListeners();
        }).catchError((e) {
          print(e);
        });
      }).catchError((e) {
        print(e);
      });
    }).catchError((e) {
      print(e);
    });
  }

  Future updateNickName(String newName) async {
    // var userInfo = new UserUpdateInfo();
    // userInfo.displayName = newName;
    await FirebaseAuth.instance.currentUser!
        .updateProfile(displayName: newName)
        .then((val) {
      // FirebaseAuth.instance.currentUser().then((user) {
      FirebaseFirestore.instance
          .collection('/user_master')
          .where('user_id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((doc) {
        FirebaseFirestore.instance
            .doc('/user_master/${doc.docs[0].id}')
            .update({'displayName': newName}).then((val) {
          print('updated');
          notifyListeners();
        }).catchError((e) {
          print(e);
        });
      }).catchError((e) {});
    }).catchError((e) {});
  }
}
