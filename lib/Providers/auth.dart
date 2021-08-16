import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:async';
import 'package:shocase/Models/user.dart';

import 'package:shocase/Models/httpException.dart';

class Auth with ChangeNotifier {
  late String _token;
  final _firestore = FirebaseFirestore.instance;
  DateTime? _expiryDate;
  String? _userId;
  Timer? _authTimer;
  String? _userName;
  String? _phone;
  final _auth = FirebaseAuth.instance;
  final CollectionReference _usersCollectionReference = FirebaseFirestore.instance.collection("user_master");

  // bool get isAuth {
  //   return _token != null;
  // }

  bool get isAuth {
    if (token == null) {
      return false;
    } else {
      return true;
    }
  }

  String? get token {
    if (_expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    // print("Token NULL: "+_token);
    return null;
  }

  String get userId {
    return _userId.toString();
  }

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    print("This Username : "+ this._userName.toString());
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/$urlSegment?key=AIzaSyD4w5PKXxkN8XiBiKIz2ZNLc8McHpLQihA');
    try {
      // print("Auth URL : "+url.toString());
      final response = await http.post(
        url,
        body: json.encode(
          {'email': email, 'password': password, 'returnSecureToken': true},
        ),
      );
      final responseData = json.decode(response.body);
      print("Response Data : " + responseData.toString());
      if (responseData['error'] != null) {
        print("Response Data Error : "+ responseData['error']['message']);
        throw Exception(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseData['expiresIn'],
          ),
        ),
      );

      // if (urlSegment == 'accounts:signUp'){
      //   print("Signup In-progress");
      //   _usersCollectionReference.doc(_userId).set({
      //     'user_email': email,
      //     'user_name': this._userName,
      //     'user_id': _userId,
      //     'user_mobile': this._phone,
      //   });
      // }

      _autoLogout();
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        'userId': _userId,
        'expiryDate': _expiryDate!.toIso8601String()
      });
      prefs.setString('userData', userData);
    } catch (error) {
      throw error;
    }
  }

  // Future<void> signup(String email, String password, String username, String phone) async {
  //   print("Username For Signup: "+ username);
  //   print("Email For Signup: "+ email);
  //   this._userName = username;
  //   this._phone = phone;
  //   return _authenticate(email, password, 'accounts:signUp');
  // }

  Future<void> signup() async {
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'accounts:signInWithPassword');
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')){
      return false;
    }
    final extractedUserData = json.decode(prefs.getString('userData')!) as Map<String, Object>;
    final expiryDate = DateTime.parse(extractedUserData['expiryDate'].toString());

    if(expiryDate.isBefore(DateTime.now())){
      return false;
    }
    _token = extractedUserData['token'].toString();
    _userId = extractedUserData['userId'].toString();
    _expiryDate = expiryDate;
    notifyListeners();
    return true;
  }

  void logout() async{
    // FirebaseAuth.instance.currentUser!.delete();
    await FirebaseAuth.instance.signOut();
    _token = "";
    _userId = "";
    _expiryDate = null;
    if (_authTimer != null) {
      _authTimer!.cancel();
      _authTimer = null;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    // prefs.remove('userData')
    prefs.clear();
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer!.cancel();
    }
    final timeToExpiry = _expiryDate!.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }

  Future<String> getCurrentUserId() async {
    return (await FirebaseAuth.instance.currentUser!.uid);
  }

  // Future<UserModel> getUser() async {
  //   var firebaseUser = await _auth.currentUser!;
  //   return UserModel(firebaseUser.uid, displayName: firebaseUser.displayName);
  // }

}
