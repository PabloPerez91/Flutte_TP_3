import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:exo_3/MyHomePage.dart';
import 'job.dart';


void main() async {

  await Hive.initFlutter();
  Hive.registerAdapter(JobAdapter());
  await Hive.openBox<Job>(MyApp.jobsbox);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static const String jobsbox = "jobs";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter TP3',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Calculation App'),
    );
  }
}