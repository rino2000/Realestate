// ignore_for_file: non_constant_identifier_names, file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../fetch.dart';
import '../models/House.dart';

class CreateHouse extends StatefulWidget {
  final int brokerID;
  const CreateHouse({Key? key, required this.brokerID}) : super(key: key);

  @override
  State<CreateHouse> createState() => _CreateHouseState();
}

class _CreateHouseState extends State<CreateHouse> {
  late TextEditingController title_controller = TextEditingController();
  late TextEditingController price_controller = TextEditingController();
  late TextEditingController plot_controller = TextEditingController();
  late TextEditingController bathrooms_controller = TextEditingController();
  late TextEditingController bedrooms_controller = TextEditingController();
  late TextEditingController living_space_controller = TextEditingController();
  late TextEditingController plot_size_controller = TextEditingController();
  late TextEditingController description_controller = TextEditingController();
  late TextEditingController city_controller = TextEditingController();
  late TextEditingController country_controller = TextEditingController();

  final formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    title_controller.dispose();
    price_controller.dispose();
    plot_controller.dispose();
    bathrooms_controller.dispose();
    bedrooms_controller.dispose();
    living_space_controller.dispose();
    plot_size_controller.dispose();
    description_controller.dispose();
    city_controller.dispose();
    country_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formkey,
          child: Column(
            children: [
              const Text(
                "Create House",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              CupertinoTextField(
                  controller: title_controller, placeholder: "Title"),
              CupertinoTextField(
                  controller: price_controller, placeholder: "Price"),
              CupertinoTextField(
                  controller: bathrooms_controller, placeholder: "Bathrooms"),
              CupertinoTextField(
                  controller: bedrooms_controller, placeholder: "Bedrooms"),
              CupertinoTextField(
                  controller: living_space_controller,
                  placeholder: "Livinspace"),
              CupertinoTextField(
                  controller: plot_size_controller, placeholder: "Plotsize"),
              CupertinoTextField(
                  controller: description_controller,
                  placeholder: "Description"),
              CupertinoTextField(
                  controller: city_controller, placeholder: "City"),
              CupertinoTextField(
                  controller: country_controller, placeholder: "Country"),
              TextButton.icon(
                onPressed: () {
                  if (formkey.currentState!.validate()) {
                    House house = House(
                      title: title_controller.text.trim(),
                      price: price_controller.text.trim(),
                      bathrooms: bathrooms_controller.text.trim(),
                      bedrooms: bedrooms_controller.text.trim(),
                      living_space: living_space_controller.text.trim(),
                      plot: plot_size_controller.text.trim(),
                      plot_size: plot_size_controller.text.trim(),
                      description: description_controller.text.trim(),
                      city: city_controller.text.trim(),
                      country: country_controller.text.trim(),
                      created: DateTime.now().toString(),
                      broker_id: widget.brokerID,
                    );

                    createHouse(house).then(
                      (bool value) => value
                          ? Navigator.pop(context)
                          : ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Colors.red,
                                content: Center(
                                  child: Text(
                                    "Error while creating house",
                                    style: TextStyle(fontSize: 30),
                                  ),
                                ),
                                duration: Duration(seconds: 2),
                              ),
                            ),
                    );
                  }
                },
                icon: const Icon(Icons.create_rounded),
                label: const Text("Create"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
