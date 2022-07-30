import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'models/Broker.dart';
import 'models/House.dart';
import 'models/Token.dart';

Future<List<House>> fetchHouses() async {
  final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/data/'));

  if (response.statusCode == 200) {
    List<House> r = List<House>.from(
        json.decode(response.body).map((data) => House.fromJson(data)));
    return r;
  }
  return Future.error('Failed to load houses');
}

Future<Broker> fetchBroker() async {
  final sp = await SharedPreferences.getInstance();
  final token = sp.getString('token');
  final response = await http.get(
    Uri.parse('http://127.0.0.1:8000/api/broker/'),
    headers: {
      HttpHeaders.authorizationHeader: 'Token $token',
    },
  );

  if (response.statusCode == 200) {
    return Broker.fromJson(jsonDecode(response.body));
  }
  return Future.error('Failed to load broker');
}

Future<List<House>> fetchBrokerHouses() async {
  final sp = await SharedPreferences.getInstance();
  final token = sp.getString('token');
  final response = await http.get(
    Uri.parse('http://127.0.0.1:8000/api/broker/houses/'),
    headers: {
      HttpHeaders.authorizationHeader: 'Token $token',
    },
  );

  if (response.statusCode == 200) {
    List<House> r = List<House>.from(
        json.decode(response.body).map((data) => House.fromJson(data)));
    return r;
  }
  return Future.error('Failed to load houses');
}

Future<Token> login(String? email, String? password) async {
  final response = await http.post(
    Uri.parse('http://127.0.0.1:8000/api-token-auth/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'username': email!,
      'password': password!,
    }),
  );

  if (response.statusCode == 200) {
    return Token.fromJson(jsonDecode(response.body));
  }
  return Future.error("FAiled to get token");
}
