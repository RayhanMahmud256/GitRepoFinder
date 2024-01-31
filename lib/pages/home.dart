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
  int page = 1;
  bool loading = true;
  List list = [];
  final scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchdata();
    scrollController.addListener(_scrolllistener);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter-Repos'),
        centerTitle: true,
      ),
      body: Center(
        child: loading
            ? CircularProgressIndicator()
            : list.isEmpty
                ? Text('Sorry we dont have any data')
                : ListView.builder(
                    controller: scrollController,
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      final repo = list[index];
                      return ListTile(
                        title: Text(repo['name']),
                        subtitle: Text(repo['full_name']),
                        trailing: Text(repo['id'].toString()),
                      );
                    },
                  ),
      ),
    );
  }

  Future<void> fetchdata() async {
    final apikey = 'https://api.github.com/search/repositories?q=topic:ios&per_page=10&page=$page';
    final response = await http.get(Uri.parse(apikey));
    if(response.statusCode == 200) {
      final map = jsonDecode(response.body);
      setState(() {
        List ls = map['items'] as List;
        list = list + ls;
        loading = false;
      });
    }
  }

  void _scrolllistener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      page = page + 1;
      fetchdata();
    }
  }
}
