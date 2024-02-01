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
  final scrollController = ScrollController();

  Widget build(BuildContext context) {
    print('Build');

    final myProvider = Provider.of<ApiProvider>(context);
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        myProvider.page = myProvider.page + 1;
        myProvider.fetchdata();
      }
    });

    return Scaffold(
        appBar: AppBar(
          title: const Text('GitFinder'),
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
                          myProvider.list.clear();
                          myProvider.topicname =
                              _reponamecontroller.text.trim();
                          myProvider.loading = true;
                          myProvider.starting = false;
                          myProvider.fetchdata();
                        });
                      },
                      child: const Text('Search'),
                    ),
                  ),
                  DropdownButton(
                    value: myProvider.dropdownval,
                    items: const [
                      DropdownMenuItem(
                        child: Text("star_Count"),
                        value: 0,
                      ),
                      DropdownMenuItem(
                        child: Text("updated_at"),
                        value: 1,
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        if (value == 0)
                          myProvider.repoorder = 'stargazers_count';
                        else
                          myProvider.repoorder = 'updated_at';
                        if (myProvider.list.isNotEmpty) {
                          myProvider.list.clear();
                          myProvider.fetchdata();
                        }
                      });
                    },
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              if (myProvider.list.isNotEmpty)
                Text("Total_Repository Found: " +
                    myProvider.list.length.toString()),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                  child: myProvider.starting? const Center(child: Text('Search your repositories')):myProvider.loading
                      ? const Center(child: CircularProgressIndicator())
                      : myProvider.list.isEmpty
                          ? const Center(child: Text('No data found'))
                          : ListView.builder(
                              controller: scrollController,
                              itemCount: myProvider.list.length,
                              itemBuilder: (context, index) {
                                final repo = myProvider.list[index];
                                return ListTile(
                                  title: Text(repo['full_name']),
                                  subtitle:
                                      Text("Owner: " + repo['owner']['login']),
                                  trailing: Text('Total_Stars: ' +
                                      repo['stargazers_count'].toString()),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            repo_details(index),
                                      ),
                                    );
                                  },
                                );
                              })),
            ],
          ),
        ));
  }
}
