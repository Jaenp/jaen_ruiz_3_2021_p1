import 'package:flutter/material.dart';
import 'package:jaen_ruiz_3_2021_p1/screens/anime_home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Animes App',
      home: anime_home_screen(),
    );
  }
}