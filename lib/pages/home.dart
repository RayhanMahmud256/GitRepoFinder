import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gitapihandler/pages/repo_details.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../providers/apiprovider.dart';

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
  String repoorder = 'stargazers_count';
  int dropdownval = 0;

  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(_scrolllistener);
  }

  Widget build(BuildContext context) {
    final myProvider = Provider.of<ApiProvider>(context);
    myProvider.setlist(list);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Github Searcher'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 15,
              ),

          TextField(
                controller: _reponamecontroller,
                decoration: const InputDecoration(
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
                  GestureDetector(
                    child: ElevatedButton(
                      onPressed: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        setState(() {
                          list.clear();
                          topicname = _reponamecontroller.text.trim();
                          loading = true;
                          fetchdata();
                        });
                      },
                      child: const Text('Search'),
                    ),
                  ),
                  DropdownButton(
                    value: dropdownval,
                    items: [ //add items in the dropdown
                      DropdownMenuItem(
                          child: Text("star_Count"),
                          value: 0,
                      ),

                      DropdownMenuItem(
                        child: Text("updated_at"),
                        value: 1,
                      ),
                    ],
                    onChanged: (value){ //get value when changed
                       setState(() {
                         if(value == 0) repoorder = 'stargazers_count';
                         else repoorder = 'updated_at';
                         if(list.isNotEmpty) {
                           list.clear();
                           fetchdata();
                         }
                       });
                    },
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              if(list.isNotEmpty) Text("Total_Repository Found: " + list.length.toString()),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                  child: loading
                      ? const Center(child: CircularProgressIndicator())
                      : list.isEmpty
                      ? const Center(child: const Text('No data found'))
                      : ListView.builder(
                      controller: scrollController,
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        final repo = list[index];
                        return ListTile(
                          title: Text(repo['full_name']),
                          subtitle: Text("Owner: " + repo['owner']['login']),
                          trailing: Text('Total_Stars: ' + repo['stargazers_count'].toString()),
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => repo_details(index),
                              ),
                            );
                          },
                        );
                      }))
            ],
          ),
        ));
  }


  Future<void> fetchdata() async {
    final apikey = 'https://api.github.com/search/repositories?q=name:$topicname&sort=$repoorder&order=desc&per_page=10';
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