import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../models/House.dart';

class HouseItem extends StatefulWidget {
  final List<House> data;
  final int index;
  const HouseItem({Key? key, required this.data, required this.index})
      : super(key: key);

  @override
  State<HouseItem> createState() => _HouseItemState();
}

class _HouseItemState extends State<HouseItem> {
  final Shader linearGradient = const LinearGradient(
    colors: <Color>[
      Color.fromARGB(255, 126, 62, 113),
      Color.fromARGB(255, 193, 0, 252)
    ],
  ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
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
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 10),
              child: Text(
                widget.data[widget.index].title!,
                style: const TextStyle(fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                NumberFormat.currency(locale: 'de_DE')
                    .format(int.parse(widget.data[widget.index].price!))
                    .toString(),
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    foreground: Paint()..shader = linearGradient,
                    letterSpacing: -2),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(Icons.maps_home_work_outlined),
                Text(widget.data[widget.index].city!),
                const FaIcon(FontAwesomeIcons.globe),
                Text(widget.data[widget.index].country!),
              ],
            ),
            const Divider(
                height: 10,
                color: Colors.blueAccent,
                indent: 10,
                endIndent: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(Icons.bed),
                Text(widget.data[widget.index].bedrooms!),
                const Icon(Icons.bathtub_outlined),
                Text(widget.data[widget.index].bathrooms!),
                const Icon(Icons.policy_sharp), //Living space
                Text(widget.data[widget.index].living_space!),
                const Icon(Icons.space_bar_outlined), //Plot size
                Text(widget.data[widget.index].plot_size!),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
