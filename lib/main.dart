import 'package:flutter/material.dart';
import 'package:manga_app/src/pages/home_manga_page.dart';
import 'package:manga_app/src/pages/home_page.dart';
import 'package:manga_app/src/pages/mangainfo_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'home',
      routes: {
        'home'       : ( BuildContext context ) => HomePage(),
        'mangainfo' : ( BuildContext context ) => MangaInfoPage(),
      }
    );
  }
}