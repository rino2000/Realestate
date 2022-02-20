// ignore_for_file: non_constant_identifier_names, must_be_immutable, prefer_const_constructors
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'models.dart';

class HouseList extends StatefulWidget {
  const HouseList({Key? key}) : super(key: key);

  @override
  State<HouseList> createState() => _HouseListState();
}

class _HouseListState extends State<HouseList> {
  Future<List<House>>? futureHouse;
  Future<List<House>>? fetchData() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/api/data/'), headers: {
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200) {
      List jsonResponse = await json.decode(response.body);
      return jsonResponse.map((data) => House.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    futureHouse = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<House>?>(
      future: futureHouse,
      builder: (context, snapshot) {
        if (snapshot.hasData &&
            snapshot.connectionState == ConnectionState.done) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) {
              var item = snapshot.data![index];
              return HouseItem(
                image: item.image,
                title: item.title,
                price: item.price,
                plot: item.plot,
                living_space: item.living_space,
                description: item.description,
                bedrooms: item.bedrooms,
                bathrooms: item.bathrooms,
              );
            },
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }
        return Center(child: CircularProgressIndicator.adaptive());
      },
    );
  }
}

class HouseItem extends StatefulWidget {
  String? image, title, price, plot, living_space, description;
  int? bathrooms, bedrooms;
  HouseItem({
    Key? key,
    this.image,
    this.title,
    this.price,
    this.plot,
    this.living_space,
    this.description,
    this.bedrooms,
    this.bathrooms,
  }) : super(key: key);

  @override
  State<HouseItem> createState() => _HouseItemState();
}

class _HouseItemState extends State<HouseItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 2, color: Colors.blue),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.6),
              spreadRadius: 5,
              blurRadius: 3,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(widget.image.toString(), fit: BoxFit.fill),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                  child: Column(
                    children: [
                      Text(widget.title.toString(),
                          style: TextStyle(overflow: TextOverflow.ellipsis)),
                      Text(
                        widget.price.toString() + ' €',
                        style: const TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            WidgetSpan(child: Icon(Icons.square_foot_rounded)),
                            TextSpan(
                                text: widget.plot.toString() + ' ㎡',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            WidgetSpan(child: Icon(Icons.shower_rounded)),
                            TextSpan(
                                text: widget.bathrooms.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            WidgetSpan(child: Icon(Icons.bed_sharp)),
                            TextSpan(
                                text: widget.bedrooms.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      Text(widget.description.toString(),
                          style: TextStyle(overflow: TextOverflow.ellipsis)),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
