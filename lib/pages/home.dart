import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/apimodel.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  final String apikey = 'https://api.github.com/search/repositories?q={flutter}{&page,per_page,sort,order}';
  bool loading = false;
  List list = [];

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter-Repos'),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index){
            final repo = list[index];
            return ListTile(
              title: Text(repo['name']),
              subtitle: Text(repo['full_name']),
              trailing: Text(repo['id'].toString()),
            );
          },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
            final response = await http.get(Uri.parse(apikey));
            setState(() {
               final map = jsonDecode(response.body);
               list = map['items'] as List;
            });
          },
        child: const Icon(Icons.find_in_page),
      ),
    );
  }
}
