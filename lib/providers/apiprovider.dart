import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class ApiProvider extends ChangeNotifier {

  List _list = [];
  List get list => _list;

  int page = 1;
  bool loading = false;
  String topicname = '';
  String repoorder = 'stargazers_count';
  int dropdownval = 0;
  bool starting = true;


  Future<void> fetchdata() async {
    try {
      final apikey = 'https://api.github.com/search/repositories?q=name:$topicname&sort=$repoorder&order=desc&per_page=10';
      final response = await http.get(Uri.parse(apikey));
      if (response.statusCode == 200) {
        final map = jsonDecode(response.body);
        List ls = map['items'] as List;
        _list = _list + ls;
        loading = false;
        notifyListeners();
      }
      else {
        throw Exception('Failed to Load Data: ${response.statusCode}');
      }
    }
    catch (e) {
      // Handle the exception
      print(e);
      // Show an error message to the user
    }
  }
}