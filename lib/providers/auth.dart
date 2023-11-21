import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_shop/models/http_exception.dart';

class Auth with ChangeNotifier {
  // String? _token;
  // DateTime? _expiryDate;
  // String? _userId;

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
      var authData = json.decode(response.body);
      if (authData['error'] != null) {
        throw HttpException(authData['error']['message']);
      }
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
