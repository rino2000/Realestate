import 'package:flutter/material.dart';

class SearchCity extends SearchDelegate<String> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.close),
        onPressed: () => query = '',
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_outlined),
      onPressed: () => print('test'),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> citys = ["test", 'berli', 'marbella'];
    return ListView.builder(
      itemBuilder: ((context, index) => ListTile(
            title: Text(
              citys[index],
            ),
          )),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView.builder(
      itemBuilder: ((context, index) => const ListTile(
            title: Text("testess"),
          )),
    );
  }
}
