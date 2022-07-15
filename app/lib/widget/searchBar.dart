// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

class SpaceBar extends StatefulWidget {
  const SpaceBar({Key? key}) : super(key: key);

  @override
  State<SpaceBar> createState() => _SpaceBarState();
}

class _SpaceBarState extends State<SpaceBar> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Column(
      children: [
        Form(
          key: formKey,
          child: TextFormField(
            decoration: const InputDecoration(
              hintText: 'Search for city',
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some city';
              }
              return null;
            },
          ),
        ),
        TextButton(
          onPressed: () => print("Search"),
          child: const Text("Search"),
        ),
      ],
    );
  }
}
