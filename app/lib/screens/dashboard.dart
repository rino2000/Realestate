// ignore_for_file: avoid_print

import 'package:app/screens/houseList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

  late Future<List<House>> futureHouse;

  Future<bool?> removeBroker() async {
    final i = await SharedPreferences.getInstance();
    i.remove('broker');
  }

  @override
  void initState() {
    super.initState();
    future = fetchBroker();
    futureHouse = fetchBrokerHouses();
  }

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
              FutureBuilder<List<House>>(
                  future: futureHouse,
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
                    return ListView.builder(
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
                                        Text(snapshot.data![index].title!)),
                                    DataCell(
                                      Text(
                                        "${NumberFormat.currency(locale: 'de_DE').format(double.parse(
                                          snapshot.data![index].price!,
                                        ))} €",
                                      ),
                                    ),
                                    DataCell(
                                        Text(snapshot.data![index].plot_size!)),
                                    DataCell(
                                        Text(snapshot.data![index].bedrooms!)),
                                    DataCell(
                                        Text(snapshot.data![index].bathrooms!)),
                                    DataCell(Text(
                                        snapshot.data![index].living_space!)),
                                    DataCell(Text(snapshot
                                        .data![index].broker_id
                                        .toString())),
                                    DataCell(
                                        Text(snapshot.data![index].created!)),
                                    DataCell(IconButton(
                                      icon: const Icon(Icons.delete_outline,
                                          color: Colors.red),
                                      onPressed: () => print('delete house'),
                                    )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
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
                          double.parse(
                            snapshot.data!.value!.valueSum.toString(),
                          ),
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
                      color: Colors.red,
                    ),
                    label: const Text(
                      "Logout",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
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
            onPressed: () => Navigator.pop(context),
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
