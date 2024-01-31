import 'package:flutter/material.dart';
import 'package:gitapihandler/pages/home.dart';
import 'package:gitapihandler/providers/apiprovider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ApiProvider()),
        ],
        child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: home(),
      )
      );
  }
}

