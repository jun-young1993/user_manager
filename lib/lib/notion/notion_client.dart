
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
          "Notion-Version" : version
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


  Future query(String id) async{
    http.Response res = 
        await http.post(Uri.https(host,'/$v/$path/$id/query'),
          headers: defaultHeader()
        );

        return notionResponse(res);
  }
}

class NotionClient {
  NotionDatabasesClient databases;


  
  NotionClient() 
  : this.databases = NotionDatabasesClient();
}
