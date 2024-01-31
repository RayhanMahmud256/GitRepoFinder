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
  TextEditingController _reponamecontroller = TextEditingController();
  int page = 1;
  bool loading = false;
  List list = [];
  final scrollController = ScrollController();
  String topicname = '';

  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(_scrolllistener);
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Github Searcher'),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: _reponamecontroller,
                decoration: InputDecoration(
                    hintText: 'Enter the repository name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        list.clear();
                        topicname = _reponamecontroller.text.trim();
                        loading = true;
                        fetchdata();
                      });
                    },
                    child: const Text('Search'),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                  child: loading
                      ? CircularProgressIndicator()
                      : list.isEmpty
                          ? Center(child: const Text('No data found'))
                          : ListView.builder(
                              controller: scrollController,
                              itemCount: list.length,
                              itemBuilder: (context, index) {
                                final repo = list[index];
                                return ListTile(
                                  title: Text(repo['name']),
                                );
                              }))
            ],
          ),
        ));
  }


  Future<void> fetchdata() async {
    final apikey =
        'https://api.github.com/search/repositories?q=topic:$topicname&per_page=10&page=$page';
    final response = await http.get(Uri.parse(apikey));
    if (response.statusCode == 200) {
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
