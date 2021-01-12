import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;
import 'package:manga_app/src/models/manga_model.dart';


class MangasProvider{

  List<MangaModel> mangas = new List();
  MangaModel mangaElement = new MangaModel();

   Future<List<MangaModel>> getData() async{

    final response = await http.get('http://mangafox.icu/latest-manga');
    dom.Document document = parser.parse(response.body);

    final titleElement       = document.getElementsByClassName('list-truyen-item-wrap');
    final descriptionElement = document.getElementsByClassName('list-truyen-item-wrap');
    final imagesElement      = document.getElementsByClassName('list-truyen-item-wrap');
    final chaptersElement    = document.getElementsByClassName('list-truyen-item-wrap');

    
    mangaElement.title = titleElement
         .map((element) =>
    element.getElementsByTagName("a")[0].attributes['title'])
         .toList();

    mangaElement.description = descriptionElement
         .map((element) =>
    element.getElementsByTagName("p")[0].innerHtml)
         .toList();

    mangaElement.image = imagesElement
         .map((element) =>
    element.getElementsByTagName("img")[0].attributes['src'])
         .toList();

    mangaElement.chapters = chaptersElement
         .map((element) =>
    element.getElementsByTagName("a")[2].innerHtml)
         .toList();

    mangaElement.title.forEach((value){
          final man= MangaModel();
          mangas.add(man);
    });

    return  mangas;
  }
}