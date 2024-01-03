import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/http_exception.dart';

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;
  Timer? _logoutTimer;

  bool get isAuth {
    return token != null;
  }

  String? get userId {
    return _userId;
  }

  String? get token {
    if (_token != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _expiryDate != null) {
      return _token;
    }
    return null;
  }

  Future<void> authenticate(
      String? email, String? password, String authOption) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$authOption?key=AIzaSyCG69J4wOXi3N6jKfFhcXKpQlo2Lbdu5Gs';
    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }),
      );
      final authData = json.decode(response.body);
      // print(authData);
      if (authData['error'] != null) {
        throw HttpException(authData['error']['message']);
      }
      if (authOption == 'signInWithPassword') {
        _token = authData['idToken'];
        _userId = authData['localId'];
        _expiryDate = DateTime.now().add(
          Duration(
            seconds: int.parse(authData['expiresIn']),
          ),
        );
      }
      _authoLogout();
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(
        {
          'token': _token,
          'userId': _userId,
          'expiryDate': _expiryDate!.toIso8601String()
        },
      );
      prefs.setString('userData', userData);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> autoLogIn() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData')!) as Map<String, Object>;
    final expiryDate =
        DateTime.parse(extractedUserData['expiryDate'] as String);
    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    _token = extractedUserData['token'] as String;
    _userId = extractedUserData['userId'] as String;
    _expiryDate = expiryDate;
    notifyListeners();
    _authoLogout();
    return true;
  }

  Future<void> signUp(String? email, String? password) async {
    return authenticate(email, password, 'signUp');
  }

  Future<void> logIn(String? email, String? password) async {
    return authenticate(email, password, 'signInWithPassword');
  }

  void logout() {
    _token = null;
    _userId = null;
    _expiryDate = null;
    if (_logoutTimer != null) {
      _logoutTimer!.cancel();
      _logoutTimer = null;
    }
    notifyListeners();
  }

  void _authoLogout() {
    if (_logoutTimer != null) {
      _logoutTimer!.cancel();
    }
    final timeToExpire = _expiryDate!.difference(DateTime.now()).inSeconds;
    _logoutTimer = Timer(
      Duration(seconds: timeToExpire),
      () {
        logout();
      },
    );
  }
}
