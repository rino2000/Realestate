// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  @override
  void initState() {
    super.initState();
    future = fetchBroker();
    futureHouse = fetchBrokerHouses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black),
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
              const SizedBox(height: 10),
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
                    return SizedBox(
                      height: 200,
                      child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return DataTable(
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
                                  DataCell(Text(snapshot.data![index].title!)),
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
                                  DataCell(Text(snapshot.data![index].broker_id
                                      .toString())),
                                  DataCell(
                                      Text(snapshot.data![index].bathrooms!)),
                                  DataCell(IconButton(
                                    icon: const Icon(Icons.delete_outline,
                                        color: Colors.red),
                                    onPressed: () => print('delete house'),
                                  )),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                    );
                  }),
              const SizedBox(height: 10),
              FutureBuilder<Broker>(
                  future: future,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator.adaptive();
                    }
                    return Text(
                      "Total House Value ${NumberFormat.currency(locale: 'de_DE').format(
                        double.parse(
                          snapshot.data!.value!.valueSum.toString(),
                        ),
                      )} €",
                      style: const TextStyle(
                        fontSize: 23,
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }),
              const SizedBox(height: 10),
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
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SelectableText(
                            "Your Email = ${snapshot.data!.brokerData!.email!}",
                            style: const TextStyle(
                                color: Colors.red,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          SelectableText(
                            "Your Name = ${snapshot.data!.brokerData!.name!}",
                            style: const TextStyle(
                                color: Colors.red,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
              TextButton.icon(
                onPressed: () => _showAlertDialog(context),
                icon: const Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                ),
                label: const Text(
                  "Delete Profile",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAlertDialog(BuildContext context) {
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
}
