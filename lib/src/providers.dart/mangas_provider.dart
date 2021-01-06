import 'package:http/http.dart' as http;


class MangasProvider{

  String _url = 'www.mangatown.com';

  void getHtmlResult() async{
    var response = await http.get(_url);
    //If the http request is successful the statusCode will be 200
    if(response.statusCode == 200){
      String htmlResult = response.body;
      print(htmlResult);
    }
  }

}