// ignore_for_file: non_constant_identifier_names

import 'package:app/screens/houseList.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../fetch.dart';
import '../models/Token.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  var email_controller = TextEditingController();
  var password_controller = TextEditingController();

  late Future<Token> future_toke;

  Future<void> add(String? token) async {
    final sp = await SharedPreferences.getInstance();
    await sp.setString('token', token!);
  }

  Future<void> brokerSP(List<String> broker) async {
    final sp = await SharedPreferences.getInstance();
    await sp.setStringList('broker', broker);
  }

  @override
  void dispose() {
    email_controller.dispose();
    password_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                TextFormField(
                  controller: email_controller,
                  style: const TextStyle(color: Colors.red),
                  keyboardType: TextInputType.emailAddress,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a Email Address';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: const BorderSide(
                        color: Colors.purple,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: const BorderSide(
                        color: Colors.red,
                        width: 2.0,
                      ),
                    ),
                    border: const OutlineInputBorder(),
                    hintText: 'Email',
                    hintStyle: const TextStyle(color: Colors.red),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: password_controller,
                  style: const TextStyle(color: Colors.red),
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: const BorderSide(
                        color: Colors.purple,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: const BorderSide(
                        color: Colors.red,
                        width: 2.0,
                      ),
                    ),
                    border: const OutlineInputBorder(),
                    hintText: 'Password',
                    hintStyle: const TextStyle(color: Colors.red),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        brokerSP([
                          email_controller.text.trim(),
                          password_controller.text.trim()
                        ]);
                        future_toke = login(email_controller.text.trim(),
                            password_controller.text.trim());

                        future_toke.then((value) => add(value.token));

                        future_toke.whenComplete(
                            () => Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const HouseList(),
                                  ),
                                ));
                      });
                    }
                  },
                  child: const Text('Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
