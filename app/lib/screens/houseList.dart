// ignore_for_file: file_names
import 'package:flutter/material.dart';

import '../fetch.dart';
import '../models/House.dart';
import '../widget/houseItem.dart';
import '../widget/search.dart';

class HouseList extends StatefulWidget {
  const HouseList({Key? key}) : super(key: key);

  @override
  State<HouseList> createState() => _HouseListState();
}

class _HouseListState extends State<HouseList> {
  late Future<List<House>> futureHouse;

  @override
  void initState() {
    super.initState();
    futureHouse = fetchHouses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: IconButton(
          icon: const Icon(Icons.search),
          onPressed: () => showSearch(
            context: context,
            delegate: SearchCity(),
          ),
        ),
      ),
      extendBody: true,
      body: FutureBuilder<List<House>>(
        future: futureHouse,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: ((context, index) => HouseItem(
                    data: snapshot.data!,
                    index: index,
                  )),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
