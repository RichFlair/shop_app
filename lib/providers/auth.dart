import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_shop/models/http_exception.dart';

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;

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
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signUp(String? email, String? password) async {
    return authenticate(email, password, 'signUp');
  }

  Future<void> logIn(String? email, String? password) async {
    return authenticate(email, password, 'signInWithPassword');
  }
}
