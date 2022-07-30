// ignore_for_file: file_names, avoid_print
import 'package:app/screens/login.dart';
import 'package:flutter/material.dart';

import '../fetch.dart';
import '../models/House.dart';
import '../widget/houseItem.dart';
import 'dashboard.dart';

class HouseList extends StatefulWidget {
  const HouseList({Key? key}) : super(key: key);

  @override
  State<HouseList> createState() => _HouseListState();
}

class _HouseListState extends State<HouseList> {
  late Future<List<House>> futureHouse;

  int _selectedIndex = 0;
  bool isLoggedIn = false;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    futureHouse = fetchHouses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
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
          return const Center(child: CircularProgressIndicator.adaptive());
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.white,
        backgroundColor: Colors.black,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.purple,
        onTap: _onItemTapped,
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Houses',
          ),
          // BottomNavigationBarItem(
          //   icon: IconButton(
          //     icon: const Icon(Icons.search_rounded),
          //     onPressed: () => Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => const HouseList()),
          //     ),
          //   ),
          //   label: 'Search',
          // ),
          BottomNavigationBarItem(
            icon: IconButton(
              icon: const Icon(Icons.dashboard_rounded),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Dashboard()),
              ),
            ),
            label: 'Dashboard',
          ),
          isLoggedIn
              ? BottomNavigationBarItem(
                  icon: IconButton(
                    icon: const Icon(Icons.dashboard_rounded),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Dashboard()),
                    ),
                  ),
                  label: 'Dashboard',
                )
              : BottomNavigationBarItem(
                  icon: IconButton(
                    icon: const Icon(Icons.login_rounded),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Login()),
                    ),
                  ),
                  label: 'Login',
                ),
        ],
      ),
    );
  }
}
