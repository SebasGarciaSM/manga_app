import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:manga_app/src/inherited/inherited_manga.dart';
import 'package:manga_app/src/models/manga_model.dart';
import 'package:manga_app/src/providers/mangas_provider.dart';
import 'package:web_scraper/web_scraper.dart';


  class MangaChapter extends StatefulWidget {
    @override
    _MangaChapterState createState() => _MangaChapterState();
  }
  
  class _MangaChapterState extends State<MangaChapter> {
    
    int currentPage = 1;

    /*List<Map<String, dynamic>> contentPages;
    bool dataFetched = false;

    void getContent() async{
      final webScraper = WebScraper('https://manhuas.net/');
      String tempRoute =
      'manhua/love-at-first-night-manhua/love-at-first-night-chapter-11/';

      if(await webScraper.loadWebPage(tempRoute)){
        contentPages = webScraper.getElement('div.page-break.no-gaps > img', ['src']);
        
        setState(() {
          dataFetched = true;
        });
      }
    }*/

    @override
    void initState() {
      super.initState();
    }

    @override
    Widget build(BuildContext context) {

      final Manga mangaChapter = ModalRoute.of(context).settings.arguments;
      

      return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.skip_previous_rounded,
                color: Colors.black,
              ),
              onPressed: () {
                print('TAP');
                setState(() {
                  currentPage --;
                });
              },
            ),
            IconButton(
              icon: Icon(
                Icons.skip_next_rounded,
                color: Colors.black,
              ),
              onPressed: () {
                print('TAP');
                setState(() {
                  currentPage ++;
                });
              },
            )
          ],
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        title: Text(mangaChapter.chapterTitle, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12.0)),
        backgroundColor: Colors.transparent
        ),
        body: FutureBuilder<List<Manga>>(
          initialData: List<Manga>(),
          future: InheritedManga.of(context).helper.getChapterImages('${mangaChapter.chapterSource}$currentPage.html'),
          builder: (BuildContext context, AsyncSnapshot<List<Manga>> snapshot){
          return InkWell(
            onTap: (){
              print('TAP');
              setState(() {
                currentPage ++;
              });
            },
            child: Container(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (context, index){
                  return Stack(
                    children: [
                      Image.network(
                      snapshot.data[index].chapterSource,
                      fit: BoxFit.fitWidth,
                      loadingBuilder: (context, child, loadingProgress){
                        if(loadingProgress == null) return child;

                        return Center(
                          child: CircularProgressIndicator()
                        );
                      },
                    ),

                    Positioned(
                    top: 0.0,
                    bottom: 0.0,
                    right: 0.0,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                      child: Text('${currentPage.toString()}/${snapshot.data[index].chapterLength.toString()}',
                        //'${(snapshot.data[index].(contentPages[index])) + 1}/${snapshot.data.length}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow( // bottomLeft
                          offset: Offset(-1.5, -1.5),
                          color: Colors.black
                              ),
                              Shadow( // bottomRight
                          offset: Offset(1.5, -1.5),
                          color: Colors.black
                              ),
                              Shadow( // topRight
                          offset: Offset(1.5, 1.5),
                          color: Colors.black
                              ),
                              Shadow( // topLeft
                          offset: Offset(-1.5, 1.5),
                          color: Colors.black
                              )
                          ]
                        ),
                      ),
                    ),
                    ),
                    ]
                  );
                },
              )
            ),
          );
        },
        
      ));
    }
  }



//final List<String> imgList = [];

final List<String> imgList = [
      '//zjcdn.mangahere.org/store/manga/186/08-045.0/compressed/mclaymore_v08c045_the_witch_s_maw_v.claymore_v08_159.jpg',
      '//zjcdn.mangahere.org/store/manga/186/08-045.0/compressed/mclaymore_v08c045_the_witch_s_maw_v.claymore_v08_160.jpg',
      '//zjcdn.mangahere.org/store/manga/186/08-045.0/compressed/mclaymore_v08c045_the_witch_s_maw_v.claymore_v08_161.jpg',
      '//zjcdn.mangahere.org/store/manga/186/08-045.0/compressed/mclaymore_v08c045_the_witch_s_maw_v.claymore_v08_162.jpg'
    ];

MangasProvider mprov = new MangasProvider();


/*final List<Widget> imageSliders = imgList.map((item) => Container(
  child: Container(
    margin: EdgeInsets.all(3.0),
    child: ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
      child: Stack(
        children: <Widget>[
          Image.network('http:$item', fit: BoxFit.fill, width: 1000.0),
          Positioned(
            top: 0.0,
            bottom: 0.0,
            right: 0.0,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
              child: Text(
                '${imgList.indexOf(item) + 1}/${imgList.length}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow( // bottomLeft
                  offset: Offset(-1.5, -1.5),
                  color: Colors.black
                      ),
                      Shadow( // bottomRight
                  offset: Offset(1.5, -1.5),
                  color: Colors.black
                      ),
                      Shadow( // topRight
                  offset: Offset(1.5, 1.5),
                  color: Colors.black
                      ),
                      Shadow( // topLeft
                  offset: Offset(-1.5, 1.5),
                  color: Colors.black
                      )
                  ]
                ),
              ),
            ),
          ),
        ],
      )
    ),
  ),
)).toList();

class MangaChapter extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final mangaChapter = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        title: Text(mangaChapter.toString(), style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15.0)),
        backgroundColor: Colors.transparent
      ),
      body: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              CarouselSlider(
                options: CarouselOptions(
                  aspectRatio: 10/14,
                  enlargeCenterPage: true,
                ),
                items: imageSliders,
              ),
            ],)
          )
        
      );
  }
}*/


/*class MangaChapter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final mangaChapter = ModalRoute.of(context).settings.arguments;
    final List<String> imgList = [
      'https://cm.blazefast.co/df/b2/dfb2d45c5421b3d47a183114e5652c93.jpg',
      'https://i.pinimg.com/originals/61/3b/b1/613bb1e4fe4cc594612aa6bac37da54b.jpg',
      'https://i.pinimg.com/736x/07/d9/af/07d9afe498db59b76bf4304c4e2998ab.jpg'
    ];

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        title: Text(mangaChapter.toString(), style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15.0)),
        backgroundColor: Colors.transparent
      ),
      body: FutureBuilder(
        future: InheritedManga.of(context).helper.getChapterImages('http://mangafox.icu/lv999-no-murabito-chapter-41#1'),
        builder: (BuildContext context, AsyncSnapshot<List<Manga>> snapshot) {
          final double height = MediaQuery.of(context).size.height;
          return CarouselSlider(
            options: CarouselOptions(
              height: height,
              viewportFraction: 1.0,
              enlargeCenterPage: false,
            ),
            items: imgList.map((item) => Container(
              child: Center(
                child: Image.network(item, fit: BoxFit.cover, height: height,)
              ),
            )).toList(),
          );
        },
      ),
    );
  }

  
  /*Widget build(BuildContext context) {

    final mangaChapter = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        title: Text(mangaChapter.toString(), style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15.0)),
        backgroundColor: Colors.transparent
      ),
      body: ListView(
        children: <Widget>[
          Image.network(
            'https://xcdn-202.bato.to/00004/images/18/b3/18b36930c607535f688ed8d847252d32bcd73fca_302236_869_1247.jpg?acc=T6UKrqnuxxDjCIliFnVMyQ&exp=1611608877'
          ),
          Image(
            image: NetworkImage('https://www.guiltybit.com/wp-content/uploads/2020/02/manga-Dragon-Ball-Super-58.jpg'),
          ),
          Image(
            image: NetworkImage('https://www.guiltybit.com/wp-content/uploads/2020/02/manga-Dragon-Ball-Super-58.jpg'),
          ),
          Image(
            image: NetworkImage('https://www.guiltybit.com/wp-content/uploads/2020/02/manga-Dragon-Ball-Super-58.jpg'),
          )
        ],
      ),
    );
  }*/
}*/