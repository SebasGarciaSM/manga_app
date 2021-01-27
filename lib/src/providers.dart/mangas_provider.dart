//import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:manga_app/src/models/manga_model.dart';


class MangasProvider{

  Client _client;
  List<Manga> _manga = [];
  List<Manga> _mangaChapters = [];
  List<Manga> _mangaChapterImages = [];
  Manga _mangaDetails;

  MangasProvider(){
    this._client = Client();
  }

  Future<List<Manga>> getManga() async{

    if (_manga.length != 0) return _manga;

    final response = await _client.get('http://mangafox.icu/latest-manga');
    final document = parse(response.body);

    final mElements = document.getElementsByClassName('list-truyen-item-wrap');

    for (Element m in mElements) {
        final aTag = m.getElementsByTagName('a')[0];
        final title = aTag.attributes['title'];
        final url = aTag.attributes['href'];

        final aTag2 = m.getElementsByTagName('a')[2];
        final chapters = aTag2.text;

        final imgTag = m.getElementsByTagName('a')[0].getElementsByTagName('img')[0];
        final image = imgTag.attributes['src'];

        final pTag = m.getElementsByTagName('p')[0];
        final description = pTag.text;
        
        final manga = Manga(title: title, url: url, chapters: chapters, image: image, description: description);
        _manga.add(manga);
     
    }
    return _manga;
  }

  Future<Manga> getMangaDetails(String url) async{

    final response = await _client.get(url);
    final document = parse(response.body);

    final detailsElements = document.getElementsByClassName('manga-info-text');

    final authors = detailsElements
          .map((element) =>
      element.getElementsByTagName("li")[1].innerHtml)
          .toString();

    final views = detailsElements
          .map((element) =>
      element.getElementsByTagName("li")[5].innerHtml)
          .toString();

    final status = detailsElements
          .map((element) =>
      element.getElementsByTagName("li")[2].innerHtml)
          .toString();

    final manga = Manga(authors: authors, views: views, status: status);
    return manga;
  }

  Future<List<Manga>> getChapters(String url) async{

    if (_mangaChapters.length != 0){
      _mangaChapters.clear();
    }

    final response = await _client.get(url);
    final document = parse(response.body);

    final mElements = document.getElementsByClassName('row');

    for (Element m in mElements){
      if(m.className=='row'){
        final aTag = m.getElementsByTagName('span')[0].getElementsByTagName('a')[0];
        final allChapters = aTag.attributes['title'];
        final chapterSource = aTag.attributes['href'];
        
        final manga = Manga(allChapters: allChapters, chapterSource: chapterSource);
        _mangaChapters.add(manga);
      }
    }
    return _mangaChapters;
  }

  Future<List<Manga>> getChapterImages(String url) async{
    
    if (_mangaChapters.length != 0){
      _mangaChapters.clear();
    }

    final response = await _client.get(url);
    final document = parse(response.body);

    final mElements = document.getElementsByClassName('comic_wraCon text-center');

    for(Element m in mElements){
        final tag = m.getElementsByTagName('img')[0];
        final allChapters = tag.attributes['src'];

        final manga = Manga(allChapters: allChapters);
        _mangaChapters.add(manga);
      
    }

    return _mangaChapterImages;
  }

}