import 'dart:convert';

import 'package:user_manager/lib/notion/notion_client.dart';
class UserService {
   final String userDatabaseId = "6828ab9b03c0405a8090d9e99dd3881b";
    NotionClient client = NotionClient();

   /// user list
    Future index()async{
      final result = await client.databases.query(userDatabaseId);
      final List users = [];
      final results = result['results'];   

      for(int i=0; i<results.length; i++){
        
        String id = results[i]['id'];
        var property = results[i]['properties'];
        final List titleResponse = property['name']['rich_text'];
        String name = "no name";
        if(titleResponse.length != 0){
            name = titleResponse[0]['text']['content'];
        }

        String phoneNumber = property['phone_number']['phone_number'] ?? "-";   
        users.add({
          "id" : id,
          "name" : name,
          "phone_number" : phoneNumber
        });
      }

      return users;
    }


    Future create(data) async {
      final result = await client.pages.create({
          "parent": {
              "database_id": userDatabaseId
          },
          "properties": {
              "name": {
                  "rich_text": [
                      {
                          "text": {
                              "content": data['name']
                          }
                      }
                  ]
              },
              "phone_number": {
                  "phone_number": data['phone_number']
              }
          }
      });

      return result;
    }

    

}