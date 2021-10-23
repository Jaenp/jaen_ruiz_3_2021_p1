import 'package:flutter/material.dart';
import 'package:jaen_ruiz_3_2021_p1/screens/home_anime.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anime App',
      home: home_anime(),
    );
  }
}