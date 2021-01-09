//import 'package:flutter/material.dart';
//import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;

class Manga{
  List<String> title = List();
  List<String> description = List();
  List<String> link = List();
  List<String> images = List();
  List<String> chapters = List();
  List<String> views = List();

  getData() async {
    //final response = await http.get('http://mangafox.icu/latest-manga');
    //dom.Document document = parser.parse(response.body);

    //final elements      = document.getElementsByClassName('list-truyen-item-wrap');
    //final element2      = document.getElementsByClassName('list-truyen-item-wrap');
    //final linkElemnt    = document.getElementsByClassName('entry-title');
    //final imagesElement = document.getElementsByClassName('list-truyen-item-wrap');
    //final chaptersElement = document.getElementsByClassName('list-truyen-item-wrap');

    
    
  }

}