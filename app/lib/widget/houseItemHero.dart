import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../models/House.dart';

class HouseItemHero extends StatefulWidget {
  final List<House> data;
  final int index;
  const HouseItemHero({Key? key, required this.data, required this.index})
      : super(key: key);

  @override
  State<HouseItemHero> createState() => _HouseItemHeroState();
}

class _HouseItemHeroState extends State<HouseItemHero> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {
              setState(() => isLiked ? isLiked = false : isLiked = true);
              isLiked
                  ? ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.red,
                        content: Text("House Saved"),
                        duration: Duration(milliseconds: 500),
                      ),
                    )
                  : ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.red,
                        content: Text("House removed"),
                        duration: Duration(milliseconds: 500),
                      ),
                    );
            },
            icon: FaIcon(FontAwesomeIcons.heart,
                color: isLiked ? Colors.red : Colors.white),
          )
        ],
        title: SelectableText(widget.data[widget.index].title!),
      ),
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            //widget.data[widget.index].image!
            'https://images.adsttc.com/media/images/5ecd/d4ac/b357/65c6/7300/009d/medium_jpg/02C.jpg?1590547607',
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.data[widget.index].title!,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Text(
                  NumberFormat.currency(locale: 'de_DE')
                      .format(int.parse(widget.data[widget.index].price!))
                      .toString(),
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 10),
            child: Row(
              children: [
                const FaIcon(FontAwesomeIcons.locationDot, color: Colors.white),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  "${widget.data[widget.index].city!},${widget.data[widget.index].country}",
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        const FaIcon(FontAwesomeIcons.shower,
                            color: Colors.white),
                        Text(
                          widget.data[widget.index].bathrooms!,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        const FaIcon(FontAwesomeIcons.bed, color: Colors.white),
                        Text(
                          widget.data[widget.index].bedrooms!,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        const FaIcon(FontAwesomeIcons.shower,
                            color: Colors.white),
                        Text(
                          widget.data[widget.index].living_space!,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        const FaIcon(FontAwesomeIcons.house,
                            color: Colors.white),
                        Text(
                          widget.data[widget.index].plot_size!,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              "Description",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              widget.data[widget.index].description!,
              style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
