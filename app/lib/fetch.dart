import 'dart:convert';

import 'package:http/http.dart' as http;

import 'models/Broker.dart';
import 'models/House.dart';

Future<List<House>> fetchHouses() async {
  final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/data/'));

  if (response.statusCode == 200) {
    List<House> r = List<House>.from(
        json.decode(response.body).map((data) => House.fromJson(data)));
    return r;
  } else {
    return Future.error('Failed to load houses');
  }
}

Future<Broker> fetchBrokers() async {
  final response =
      await http.get(Uri.parse('http://127.0.0.1:8000/api/broker/'));

  if (response.statusCode == 200) {
    return Broker.fromJson(jsonDecode(response.body));
  } else {
    return Future.error('Failed to load broker');
  }
}
