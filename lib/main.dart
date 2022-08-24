import 'package:database/MySQL%20Data.dart';
import 'package:hive/hive.dart';
import 'package:database/Model/userModel.dart';


import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(userModelAdapter());
  await Hive.openBox<UserModel>("users");

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Contact',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MySQL(),
    );
  }
}
