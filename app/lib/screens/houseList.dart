// ignore_for_file: file_names, avoid_print, must_be_immutable
import 'package:app/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../fetch.dart';
import '../models/House.dart';
import '../widget/houseItem.dart';
import '../widget/houseItemHero.dart';
import 'dashboard.dart';

class HouseList extends StatefulWidget {
  const HouseList({Key? key}) : super(key: key);

  @override
  State<HouseList> createState() => _HouseListState();
}

class _HouseListState extends State<HouseList> {
  late Future<List<House>> futureHouse;

  int _selectedIndex = 0;
  bool isLoggedin = false;

  void _onItemTapped(int index) => setState(() => _selectedIndex = index);

  Future<void> loginCheck() async {
    final i = await SharedPreferences.getInstance();
    i.containsKey('broker')
        ? setState(() => isLoggedin = true)
        : setState(() => isLoggedin = false);
  }

  @override
  void initState() {
    super.initState();
    futureHouse = fetchHouses();
    loginCheck();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBody: true,
      body: StreamBuilder<List<House>>(
        stream: futureHouse.asStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          return SizedBox(
            child: ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: ((context, index) => Hero(
                    tag: UniqueKey(),
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => HouseItemHero(
                            data: snapshot.data!,
                            index: index,
                          ),
                        ),
                      ),
                      child: HouseItem(index: index, data: snapshot.data!),
                    ),
                  )),
            ),
          );
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
          //     icon: const Icon(Icons.dashboard_rounded),
          //     onPressed: () => Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => const Dashboard()),
          //     ),
          //   ),
          //   label: 'Dashboard',
          // ),
          isLoggedin
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
