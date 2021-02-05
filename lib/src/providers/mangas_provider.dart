//import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:manga_app/src/models/manga_model.dart';
import 'package:web_scraper/web_scraper.dart';


class MangasProvider{

  Client _client;
  List<Manga> _manga = [];
  List<Manga> _mangaChapters = [];
  List<Manga> _mangaLoadedChapters = [];
  List<Manga> mangaChapterImages = [];
  Manga _mangaDetails;

  MangasProvider(){
    this._client = Client();
  }

  /*Future<List<Manga>> getManga() async{

    if (_manga.length != 0) return _manga;

    final response = await _client.get('http://www.mangatown.com/latest/');
    final document = parse(response.body);

    final mElements = document.getElementsByClassName('manga_pic_list');

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
  }*/

  Future<List<Manga>> getManga() async{

    if (_manga.length != 0) return _manga;

    final response = await _client.get('http://www.mangatown.com/latest/');
    final document = parse(response.body);

    final imgElements = document.getElementsByClassName('manga_cover');
    final titleElements = document.getElementsByClassName('title');
    final titleList = titleElements.getRange(0, 30).toList();
    final ratingElements = document.getElementsByClassName('score');

    for(Element m in imgElements)
    {
      final image = m.getElementsByTagName("img")[0].attributes['src'];

      final title = m.attributes['title'];

      final url = m.attributes['href'].replaceAll('/manga', 'http://www.mangatown.com/manga');
      
      var manga = Manga(title: title, url: url, image: image);
      _manga.add(manga);

    }

    return _manga;
  }
  

  Future<Manga> getMangaDetails(String url) async{

    final response = await _client.get(url);
    final document = parse(response.body);

    final detailsElements = document.getElementsByClassName('detail_info clearfix');
    final descriptionElements = document.getElementById('show');

    final authors = detailsElements
          .map((element) =>
      element.getElementsByTagName("a")[10].innerHtml)
          .toString();

    final type = detailsElements
          .map((element) =>
      element.getElementsByTagName("a")[13].innerHtml)
          .toString();

    final rating = detailsElements
          .map((element) =>
      element.getElementsByTagName("span")[0].innerHtml.substring(0,1))
          .toString();


    final status = detailsElements
          .map((element) =>
      element.getElementsByTagName("li")[7].innerHtml.substring(17,24))
          .toString();
    
    
    final description = descriptionElements.innerHtml.replaceAll('<a class="more" href="javascript:;" onclick="cut_hide()">HIDE</a>', '').replaceAll('&nbsp;', '');

    final manga = Manga(authors: authors, type: type, rating: rating, status: status, description: description);
    return manga;
  }


  Future<List<Manga>> getChapters(String url) async{
    if (_mangaChapters.length != 0){
      _mangaChapters.clear();
    }

    final response = await _client.get(url);
    final document = parse(response.body);

    final mElements = document.getElementsByClassName('chapter_list');

    for (Element m in mElements){
      for(Element item in m.children)
      {
        final aTag = item.getElementsByTagName('a')[0];
        final chapterTitle = aTag.text.trim();
        final chapterSource = aTag.attributes['href'];
          
        final manga = Manga(chapterTitle: chapterTitle, chapterSource: chapterSource);
        _mangaChapters.add(manga);
      }
    }
    return _mangaChapters;
  }


  Future<List<Manga>> getChapterImages(String url) async{
    
    if (mangaChapterImages.length != 0){
      mangaChapterImages.clear();
    }

    final response = await _client.get(url.replaceAll('/manga', 'http://www.mangatown.com/manga'));
    final document = parse(response.body);

    final mElements = document.getElementsByClassName('read_img');
    final contentElements = document.getElementById('url');
    final mLengthElements = document.getElementsByClassName('page_select');

    final chapterLength = mLengthElements.firstWhere((element) => element.localName == 'div').getElementsByTagName('select')[0].children.length-1;

    for(Element m in mElements){
        final tag = m.getElementsByTagName('img')[0];
        final chapterSource = tag.attributes['src'];

        //final tag2 = contentElements.attr;
        final content = contentElements.attributes['value'];


        final manga = Manga(chapterSource: chapterSource.replaceAll('//', 'http://'), content: content, chapterLength: chapterLength);
        mangaChapterImages.add(manga);
    }

    return mangaChapterImages;
  }

}