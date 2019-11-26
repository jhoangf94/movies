import 'package:flutter/material.dart';
import 'package:peliculas/src/pages/detail_movie_page.dart';
import 'package:peliculas/src/pages/home_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        'detail': (BuildContext context) => DetailMovie()
      },
      theme: ThemeData(
        primaryColor: Colors.redAccent,
        primaryTextTheme: TextTheme(
          title: TextStyle(
            color: Colors.redAccent
          )
        )
      ),
      title: 'Material App',
      home: HomePage()
    );
  }
}