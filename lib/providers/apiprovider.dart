import 'package:flutter/cupertino.dart';
import 'package:gitapihandler/models/apimodel.dart';

class ApiProvider extends ChangeNotifier {
   static const endpoints = 'https://api.github.com/users/flutter/repos';

   bool isLoading = true;
   String error = '';


}