import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

//Provider class
class ApiProvider extends ChangeNotifier {
  List _list = [];
  List get list => _list;

  int page = 1;
  bool loading = false;
  String topicname = '';
  int? dropdownval = 0;
  bool starting = true;

  //Sort the list by starcount
  void sortbystar() {
    _list.sort((a,b) {
      var v1 = a['stargazers_count'];
      var v2 = b['stargazers_count'];
      return -v1.compareTo(v2);
    });
    notifyListeners();
  }

  //Sort the list by Updatetime
  void sortbyupdatetime() {
    _list.sort((a,b) {
      var v1 = a['updated_at'];
      var v2 = b['updated_at'];
      return -v1.compareTo(v2);
    });
    notifyListeners();
  }

  //getting data from github api
  Future<void> fetchdata() async {
    try {
      final apikey = 'https://api.github.com/search/repositories?q=name:$topicname&per_page=10';
      final response = await http.get(Uri.parse(apikey));
      if (response.statusCode == 200) {
        final map = jsonDecode(response.body);
        List ls = map['items'] as List;
        _list = _list + ls;
        loading = false;
        notifyListeners();
      } else {
        throw Exception('Failed to Load Data: ${response.statusCode}'); //Failed repose print
      }
    } catch (e) {
      // Handle the exception
      print(e);
      // Show an error message to the user
    }
  }
}
