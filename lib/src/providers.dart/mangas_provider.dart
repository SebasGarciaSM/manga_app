//import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:manga_app/src/models/manga_model.dart';


class MangasProvider{

  Client _client;
  List<Manga> _manga = [];
  List<Manga> _mangaChapters = [];
  List<Manga> mangaChapterImages = [];
  Manga _mangaDetails;

  MangasProvider(){
    this._client = Client();
  }

  Future<List<Manga>> getManga() async{

    if (_manga.length != 0) return _manga;

    final response = await _client.get('https://manhuas.net/');
    final document = parse(response.body);

    final mElements = document.getElementsByClassName('page-item-detail manga');

    for (Element m in mElements) {
        final aTag = m.getElementsByTagName('h3')[0].getElementsByTagName('a')[0];
        final title = aTag.text;
        final url = aTag.attributes['href'];

        final aTag2 = m.getElementsByTagName('span')[0];
        final rating = aTag2.text;

        final imgTag = m.getElementsByTagName('a')[0].getElementsByTagName('img')[0];
        final image = imgTag.attributes['src'];
        
        final manga = Manga(title: title, url: url, rating: rating, image: image);
        _manga.add(manga);
     
    }
    return _manga;
  }
  

  Future<Manga> getMangaDetails(String url) async{

    final response = await _client.get(url);
    final document = parse(response.body);

    final detailsElements = document.getElementsByClassName('post-content');
    final details2Elements = document.getElementsByClassName('post-status');
    final details3Elements = document.getElementsByClassName('summary__content');
    

    final authors = detailsElements
          .map((element) =>
      element.getElementsByTagName("a")[0].innerHtml)
          .toString();

    final type = detailsElements
          .map((element) =>
      element.getElementsByTagName("div")[30].innerHtml)
          .toString();


    final release = details2Elements
          .map((element) =>
      element.getElementsByTagName("a")[0].innerHtml)
          .toString();

    final status = details2Elements
          .map((element) =>
      element.getElementsByTagName("div")[5].innerHtml)
          .toString();
    
    final description = details3Elements
          .map((element) =>
      element.getElementsByTagName("p")[0].innerHtml)
          .toString();

    final manga = Manga(authors: authors, type: type, status: status, release: release, description: description);
    return manga;
  }


  Future<List<Manga>> getChapters(String url) async{
    if (_mangaChapters.length != 0){
      _mangaChapters.clear();
    }

    final response = await _client.get(url);
    final document = parse(response.body);

    final mElements = document.getElementsByClassName('wp-manga-chapter  ');

    for (Element m in mElements){
        final aTag = m.getElementsByTagName('div')[7];
        final chapterTitle = aTag.text;
        final chapterSource = aTag.attributes['href'];
        
        final manga = Manga(chapterTitle: chapterTitle, chapterSource: chapterSource);
        _mangaChapters.add(manga);
      
    }
    return _mangaChapters;
  }


  Future<List<Manga>> getChapterImages(String url) async{
    
    if (mangaChapterImages.length != 0){
      mangaChapterImages.clear();
    }

    final response = await _client.get(url);
    final document = parse(response.body);

    final mElements = document.getElementsByClassName('wp-manga-chapter  ');

    for(Element m in mElements){
        final tag = m.getElementsByTagName('img')[0];
        final allChapters = tag.attributes['src'];

        final manga = Manga(chapterTitle: allChapters);
        mangaChapterImages.add(manga);
    }

    return mangaChapterImages;
  }

}