// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

import '../fetch.dart';
import '../models/Broker.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late Future<Broker> future;

  @override
  void initState() {
    super.initState();
    future = fetchBroker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Total Houses 1",
                style: TextStyle(fontSize: 30, color: Colors.deepPurple),
              ),
              const SizedBox(height: 10),
              SingleChildScrollView(
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
                    rows: <DataRow>[
                      DataRow(
                        cells: <DataCell>[
                          const DataCell(Text(' test vill marbella ')),
                          const DataCell(Text('12,120,012.99€')),
                          const DataCell(Text('10')),
                          const DataCell(Text('12')),
                          const DataCell(Text('1200')),
                          const DataCell(Text('1200')),
                          const DataCell(Text('400')),
                          const DataCell(Text('12 July 2022, 09:35')),
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
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Total house value = 1,225,141,333.99 €',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Text(
                "delte profile",
                style: TextStyle(color: Colors.white),
              ),
              IconButton(
                onPressed: () => print('delete profile'),
                icon: const Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                ),
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
                    return Column(
                      children: [
                        Text(
                          snapshot.data!.email!,
                          style: const TextStyle(
                              color: Colors.red,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
