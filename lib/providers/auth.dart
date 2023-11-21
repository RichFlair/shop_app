import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  // String? _token;
  // DateTime? _expiryDate;
  // String? _userId;

  Future<void> signUp(String? email, String? password) async {
    const url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyCG69J4wOXi3N6jKfFhcXKpQlo2Lbdu5Gs';

    final response = await http.post(
      Uri.parse(url),
      body: json.encode(
          {'email': email, 'password': password, 'returnSecureToken': true}),
    );
    print(json.decode(response.body));
  }

  Future<void> logIn(String? email, String? password) async {
    const url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyCG69J4wOXi3N6jKfFhcXKpQlo2Lbdu5Gs';

    final response = await http.post(
      Uri.parse(url),
      body: json.encode(
        {'email': email, 'password': password, 'returnSecureToken': false},
      ),
    );
    print(json.decode(response.body));
  }
}
