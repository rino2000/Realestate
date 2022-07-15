// ignore_for_file: file_names

import 'package:flutter/material.dart';

class HouseList extends StatefulWidget {
  const HouseList({Key? key}) : super(key: key);

  @override
  State<HouseList> createState() => _HouseListState();
}

class _HouseListState extends State<HouseList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, idx) => HouseItem(index: idx),
      ),
    );
  }
}

class HouseItem extends StatefulWidget {
  final int index;
  const HouseItem({Key? key, required this.index}) : super(key: key);

  @override
  State<HouseItem> createState() => _HouseItemState();
}

class _HouseItemState extends State<HouseItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.blue, blurRadius: 2, spreadRadius: 2),
          ],
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: Image.network(
                'https://images.adsttc.com/media/images/5ecd/d4ac/b357/65c6/7300/009d/medium_jpg/02C.jpg?1590547607',
                width: double.infinity,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10, top: 10),
              child: Text(
                "Title",
                style: TextStyle(fontSize: 20),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                "2,780,000 €",
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -2),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Icon(Icons.maps_home_work_outlined),
                Text("city"),
                Text("county"),
              ],
            ),
            const Divider(
                height: 10,
                color: Colors.blueAccent,
                indent: 10,
                endIndent: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Icon(Icons.bed),
                Text("4"),
                Icon(Icons.bathtub_outlined),
                Text("3"),
                Icon(Icons.policy_sharp), //Living space
                Text("200"),
                Icon(Icons.space_bar_outlined), //Plot size
                Text("400"),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
