// ignore_for_file: dead_code

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'models/Broker.dart';
import 'models/House.dart';
import 'models/Token.dart';

Future<List<House>?> fetchHouses() async {
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

Future<List<House?>> fetchBrokerHouses() async {
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

Future<bool> createHouse(House house) async {
  final sp = await SharedPreferences.getInstance();

  final token = sp.getString('token');

  final response = await http.post(
    Uri.parse('http://127.0.0.1:8000/api/house/create/'),
    headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      HttpHeaders.authorizationHeader: 'Token $token',
    },
    encoding: Encoding.getByName('utf-8'),
    body: {
      'title': house.title,
      'price': house.price,
      'bathrooms': house.bathrooms,
      'bedrooms': house.bedrooms,
      'living_space': house.living_space,
      'plot_size': house.plot_size,
      'description': house.description,
      'city': house.city,
      'country': house.country,
      'created': house.created,
      'plot': house.plot_size,
      'broker': house.broker_id.toString(),
    },
  );

  if (response.statusCode == 201) {
    return true;
  } else {
    return false;
  }
}

Future<bool> deleteBroker(String id) async {
  final sp = await SharedPreferences.getInstance();

  final token = sp.getString('token');

  final response = await http.delete(
    Uri.parse('http://127.0.0.1:8000/api/broker/delete/$id/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: 'Token $token',
    },
  );

  return true ? response.statusCode == 204 : false;
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

Future<bool> logout() async {
  final response = await http.get(
    Uri.parse('http://127.0.0.1:8000/api/logout/'),
  );

  if (response.statusCode == 200) {
    return true;
  }
  return false;
}
