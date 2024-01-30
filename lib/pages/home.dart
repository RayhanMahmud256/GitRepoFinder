import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override

  final String apikey = 'https://api.github.com/search/repositories?q={flutter}{&page,per_page,sort,order}';
  bool loading = false;
  String body = '';


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter-Repos'),
        centerTitle: true,
      ),
      body: Center(
           child: Text(body),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final response = await http.get(Uri.parse(apikey));
          setState(() {
            body = response.body;
          });
        },
        child: const Icon(Icons.find_in_page),
      ),
    );
  }
}
