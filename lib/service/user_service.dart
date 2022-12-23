import 'dart:convert';
import 'dart:developer';

import 'package:user_manager/configs/colors.dart';
import 'package:user_manager/configs/constants.dart';
import 'package:user_manager/configs/statics/notion_database.dart';
import 'package:user_manager/lib/notion/notion_client.dart';
import 'package:user_manager/domain/entities/user.dart';
import 'package:user_manager/states/user/user_event.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class UserService {
    // static final storage = FlutterSecureStorage(); 
    
    // final String userDatabaseId = "6828ab9b03c0405a8090d9e99dd3881b";
    final String userDatabaseId = NotionDatabase.userId;
    
    NotionClient client = NotionClient();
    

    
   /// user list
    Future<List<User>> index()async{
      // final String userDatabaseId = await storage.read(key : 'database').toString();
    
      final result = await client.databases.query(userDatabaseId);
      final List<User> users = [];
      final results = result['results'];   

      for(int i=0; i<results.length; i++){
        
        String id = results[i]['id'];
        var property = results[i]['properties'];
        final List titleResponse = property['name']['rich_text'];
        String name = "no name";
        if(titleResponse.length != 0){
            name = titleResponse[0]['text']['content'];
        }
       final List descriptionResponse = property['description']['rich_text'];
        String description = "no description";
        if(descriptionResponse.length != 0){
          description = descriptionResponse[0]['text']['content'];
        }
        print("user job count ${property['job_count']['number']}");
        final int jobCount = property['job_count']['number'] ?? 0;

        final List colorResponse = property['color']['rich_text'];
        String color = UserColor.defaultColor.value.toString();
        if(colorResponse.length != 0){
          color = colorResponse[0]['text']['content'];
        }

        
        String phoneNumber = property['phone_number']['phone_number'] ?? "-";   
        users.add(User(id : id, name : name, phoneNumber: phoneNumber, description: description, jobCount: jobCount, color: color));
      }

      return users;
    }

    Future<User> find(String id) async {
        final result = await client.pages.find(id);
        print("user service find: $result");
        // String id = result['id'];
        var property = result['properties'];
        final List titleResponse = property['name']['rich_text'];
        String name = "no name";
        if(titleResponse.length != 0){
            name = titleResponse[0]['text']['content'];
        }

        final List descriptionResponse = property['description']['rich_text'];
        String description = "no description";
        if(descriptionResponse.length != 0){
          description = descriptionResponse[0]['text']['content'];
        }
        print("user job count ${property['job_count']['number']}");
        final int jobCount = property['job_count']['number'] ?? 0;

        final List colorResponse = property['color']['rich_text'];
        String color = UserColor.defaultColor.value.toString();

        if(colorResponse.length != 0){
          color = colorResponse[0]['text']['content'];
        }

        String phoneNumber = property['phone_number']['phone_number'] ?? "-";   
        final User user = User(id : id, name : name, phoneNumber: phoneNumber, description: description, jobCount: jobCount, color:color);
        return user;
    }


    Future<User> create(UserProperty data) async {
      print("user Property create");
      inspect(data);
      final result = await client.pages.create({
          "parent": {
              "database_id": userDatabaseId
          },
          "properties": {
              "name": {
                  "rich_text": [
                      {
                          "text": {
                              "content": data.name
                          }
                      }
                  ]
              },
              "phone_number": {
                  "phone_number": data.phoneNumber
              },
              "color" : {
                "rich_text": [
                      {
                          "text": {
                              "content": data.color
                          }
                      }
                  ]
              },
              "description" : {
                   "rich_text": [
                      {
                          "text": {
                              "content": data.description
                          }
                      }
                  ]
              },
              "disable" : {
                "checkbox" : data.disable
              },
              "job_count" : {
                "number" : data.jobCount
              }
          }
      });
      
      return User(
          id: result['id'],
          name: data.name,
          phoneNumber: data.phoneNumber,
          color : data.color,
          description: data.description,
          disable: data.disable,
          jobCount: data.jobCount

      );
    }

    Future<User> update(User data) async {
      await client.pages.update(data.id,{
          "parent": {
              "database_id": userDatabaseId
          },
          "properties": {
              "name": {
                  "rich_text": [
                      {
                          "text": {
                              "content": data.name
                          }
                      }
                  ]
              },
              "phone_number": {
                  "phone_number": data.phoneNumber
              },
              "color" : {
                 "rich_text": [
                      {
                          "text": {
                              "content": data.color
                          }
                      }
                  ]
              },
              "description" : {
                "rich_text": [
                      {
                          "text": {
                              "content": data.description
                          }
                      }
                  ]
              },
              "disable" : {
                "checkbox" : data.disable
              },
              "job_count" : {
                "number" : data.jobCount
              }
          }
      });
  
      return data;
    }

    

}