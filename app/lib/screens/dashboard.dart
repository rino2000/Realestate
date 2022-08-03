// ignore_for_file: avoid_print, non_constant_identifier_names, body_might_complete_normally_nullable, sized_box_for_whitespace

import 'package:app/screens/houseList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../fetch.dart';
import '../models/Broker.dart';
import '../models/House.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late Future<Broker> future;

  late Future<List<House?>> futureHouse;

  late int brokerID;

  final formkey = GlobalKey<FormState>();

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

  Future<bool?> removeBroker() async {
    final i = await SharedPreferences.getInstance();
    i.remove('broker');
  }

  Future<bool?> brokerId(int brokerid) async {
    final i = await SharedPreferences.getInstance();
    i.setInt('brokerId', brokerid);
  }

  @override
  void dispose() {
    super.dispose();
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
  }

  @override
  void initState() {
    super.initState();
    future = fetchBroker();
    futureHouse = fetchBrokerHouses();
    future.then((value) => setState(() => brokerID = value.brokerData!.id!));
  }

  void fetch() => setState(() {
        futureHouse = fetchBrokerHouses();
        future = fetchBroker();
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Dashboard"),
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder<Broker>(
                  future: future,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator.adaptive();
                    }
                    if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    }
                    return Text(
                      "Total Houses ${snapshot.data!.totalHouses.toString()}",
                      style: const TextStyle(
                          fontSize: 30, color: Colors.deepPurple),
                    );
                  }),
              StreamBuilder<List<House?>>(
                  stream: futureHouse.asStream(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    }
                    if (snapshot.hasError) {
                      return Text(
                        snapshot.error.toString(),
                        style: const TextStyle(fontSize: 10, color: Colors.red),
                      );
                    }
                    if (snapshot.data!.isEmpty) {
                      return const SizedBox(height: 0);
                    }
                    return Container(
                      height: 200,
                      child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: DataTable(
                                decoration: const BoxDecoration(
                                  color: Colors.deepPurple,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                                headingTextStyle: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontStyle: FontStyle.normal,
                                ),
                                dataTextStyle: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                                columns: const <DataColumn>[
                                  DataColumn(
                                    label: Text(
                                      'Title',
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Price',
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Plot',
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Bathrooms',
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Bedrooms',
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Living Space',
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Plot size',
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Created',
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Delete',
                                    ),
                                  ),
                                ],
                                rows: [
                                  DataRow(
                                    cells: <DataCell>[
                                      DataCell(
                                          Text(snapshot.data![index]!.title!)),
                                      DataCell(
                                        Text(
                                          "${NumberFormat.currency(locale: 'de_DE').format(double.parse(
                                            snapshot.data![index]!.price!,
                                          ))} €",
                                        ),
                                      ),
                                      DataCell(Text(
                                          snapshot.data![index]!.plot_size!)),
                                      DataCell(Text(
                                          snapshot.data![index]!.bedrooms!)),
                                      DataCell(Text(
                                          snapshot.data![index]!.bathrooms!)),
                                      DataCell(Text(snapshot
                                          .data![index]!.living_space!)),
                                      DataCell(Text(snapshot
                                          .data![index]!.broker_id
                                          .toString())),
                                      DataCell(Text(
                                          snapshot.data![index]!.created!)),
                                      DataCell(IconButton(
                                        icon: const Icon(Icons.delete_outline,
                                            color: Colors.red),
                                        onPressed: () {
                                          deleteHouse(snapshot.data![index]!.id
                                                  .toString())
                                              .then((value) {
                                            if (value) {
                                              fetch();
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  backgroundColor: Colors.green,
                                                  content: Text(
                                                    "House succesfully deleted",
                                                  ),
                                                ),
                                              );
                                            } else {
                                              fetch();
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  backgroundColor: Colors.red,
                                                  content: Text(
                                                    "Error while deleting house",
                                                  ),
                                                ),
                                              );
                                            }
                                          });
                                        },
                                      )),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }),
              const SizedBox(
                height: 10,
              ),
              FutureBuilder<Broker>(
                  future: future,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator.adaptive();
                    }
                    return Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.deepPurple,
                      ),
                      child: Text(
                        "Total House Value \n${NumberFormat.currency(locale: 'de_DE').format(
                          double.tryParse(
                                snapshot.data!.value!.valueSum.toString(),
                              ) ??
                              double.parse("0.00"),
                        )} €",
                        style: const TextStyle(
                          fontSize: 23,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }),
              const SizedBox(
                height: 10,
              ),
              FutureBuilder<Broker>(
                future: future,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }
                  if (snapshot.hasData) {
                    return Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.deepPurple,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SelectableText(
                              "Your Email = ${snapshot.data!.brokerData!.email!}",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            SelectableText(
                              "Your Name = ${snapshot.data!.brokerData!.name!}",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton.icon(
                    onPressed: () => delteAccountDialog(context),
                    icon: const Icon(
                      Icons.delete_outline,
                      color: Colors.red,
                    ),
                    label: const Text(
                      "Delete Account",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () => logoutDialog(context),
                    icon: const Icon(
                      Icons.logout_rounded,
                      color: Colors.yellow,
                    ),
                    label: const Text(
                      "Logout",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              TextButton.icon(
                onPressed: () {
                  print("test");
                  showCupertinoModalBottomSheet(
                    expand: true,
                    isDismissible: false,
                    enableDrag: true,
                    context: context,
                    builder: (context) {
                      return Form(
                        key: formkey,
                        child: Column(
                          children: [
                            const Text(
                              "Create House",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CupertinoTextField(
                                controller: title_controller,
                                placeholder: "Title"),
                            CupertinoTextField(
                                controller: price_controller,
                                placeholder: "Price"),
                            CupertinoTextField(
                                controller: bathrooms_controller,
                                placeholder: "Bathrooms"),
                            CupertinoTextField(
                                controller: bedrooms_controller,
                                placeholder: "Bedrooms"),
                            CupertinoTextField(
                                controller: living_space_controller,
                                placeholder: "Livinspace"),
                            CupertinoTextField(
                                controller: plot_size_controller,
                                placeholder: "Plotsize"),
                            CupertinoTextField(
                                controller: description_controller,
                                placeholder: "Description"),
                            CupertinoTextField(
                                controller: city_controller,
                                placeholder: "City"),
                            CupertinoTextField(
                                controller: country_controller,
                                placeholder: "Country"),
                            TextButton.icon(
                              onPressed: () {
                                if (formkey.currentState!.validate()) {
                                  House house = House(
                                    title: title_controller.text.trim(),
                                    price: price_controller.text.trim(),
                                    bathrooms: bathrooms_controller.text.trim(),
                                    bedrooms: bedrooms_controller.text.trim(),
                                    living_space:
                                        living_space_controller.text.trim(),
                                    plot: plot_size_controller.text.trim(),
                                    plot_size: plot_size_controller.text.trim(),
                                    description:
                                        description_controller.text.trim(),
                                    city: city_controller.text.trim(),
                                    country: country_controller.text.trim(),
                                    created: DateTime.now().toString(),
                                    broker_id: brokerID,
                                  );

                                  createHouse(house).then(
                                    (bool value) {
                                      if (value) {
                                        fetch();
                                        Navigator.pop(context);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            backgroundColor: Colors.green,
                                            content: Text(
                                              "House succesfully created",
                                            ),
                                          ),
                                        );
                                      } else {
                                        fetch();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            backgroundColor: Colors.red,
                                            content: Text(
                                              "Error while craeting house",
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                  );
                                }
                              },
                              icon: const Icon(Icons.create_rounded),
                              label: const Text("Create"),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                icon: const Icon(Icons.create_rounded, color: Colors.green),
                label: const Text(
                  "Create House",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void delteAccountDialog(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Delete Account'),
        content: const Text('Shure to delete this Account'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () => Navigator.pop(context),
            child: const Text('No'),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              removeBroker().then((bool? value) {
                if (value!) {
                  deleteBroker(brokerID.toString()).then((bool value) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HouseList()),
                      (Route<dynamic> route) => false,
                    );
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.red,
                      content: Center(
                        child: Text(
                          "Error while deleting account",
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              });
            },
            child: const Text('Yes'),
          )
        ],
      ),
    );
  }

  void logoutDialog(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Logout'),
        content: const Text('Shure to Logout?'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () => Navigator.pop(context),
            child: const Text('No'),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              removeBroker().then((value) => value!
                  ? Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HouseList()),
                      (Route<dynamic> route) => false,
                    )
                  : ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.red,
                        content: Center(
                          child: Text(
                            "Error while loggin out",
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                        duration: Duration(seconds: 2),
                      ),
                    ));
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HouseList()),
                (Route<dynamic> route) => false,
              );
            },
            child: const Text('Yes'),
          )
        ],
      ),
    );
  }
}
