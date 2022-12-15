
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'statics.dart';

class BaseClient {
  
  String token = secretToken;
  String v = notionVersion;
  String version = dateVersion;
  String host = notionApiHost;
  String path = '';
  

  defaultHeader(){
    return {
          HttpHeaders.authorizationHeader : "Bearer $token",
          "Notion-Version" : version,
          'Content-Type': 'application/json'
      };
  }

  notionResponse(http.Response response){
    return jsonDecode(response.body);
  }



}

class NotionDatabasesClient extends BaseClient{
  @override
  final String path = 'databases';

  NotionDatabasesClient() : super();


  Future query(String id, {query}) async {
    http.Response res = 
        await http.post(Uri.https(host,'/$v/$path/$id/query'),
          body : jsonEncode(query ?? {}),
          headers: defaultHeader()
        );

        return notionResponse(res);
  }

    Future create(database) async {
    http.Response res = 
        await http.post(Uri.https(host,'/$v/$path'),
          body : jsonEncode(database),
          headers: defaultHeader()
        );

        return notionResponse(res);
  }

}

class NotionPagesClient extends BaseClient{
  @override
  final String path = 'pages';

  NotionPagesClient() : super();

  Future find (String id) async {
    http.Response res = 
        await http.get(Uri.https(host,'/$v/$path/$id'),
          headers: defaultHeader()
        );
        
        return notionResponse(res);
  }

  Future create(page) async {
    http.Response res = 
        await http.post(Uri.https(host,'/$v/$path'),
          body : jsonEncode(page),
          headers: defaultHeader()
        );

        return notionResponse(res);
  }

  Future update (String id, page) async {
    http.Response res = 
      await http.patch(Uri.https(host,'$v/$path/$id'),
        body : jsonEncode(page),
        headers : defaultHeader()
      );

      return notionResponse(res);
  }

}

class NotionClient {
  NotionDatabasesClient databases;
  NotionPagesClient pages;

  
  NotionClient() 
  : this.databases = NotionDatabasesClient(),
    this.pages = NotionPagesClient();

}
