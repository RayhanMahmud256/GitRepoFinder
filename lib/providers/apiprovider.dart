import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class ApiProvider extends ChangeNotifier {

  List _list = [];
  List get list => _list;

  void setlist(List list){
    _list = _list + list;
    notifyListeners();
  }

}