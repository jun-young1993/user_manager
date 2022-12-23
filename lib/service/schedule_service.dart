import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:user_manager/configs/constants.dart';
import 'package:user_manager/configs/statics/notion_database.dart';
import 'package:user_manager/domain/entities/schedule.dart';
import 'package:user_manager/lib/notion/notion_client.dart';
import 'package:user_manager/domain/entities/user.dart';
import 'package:user_manager/service/user_service.dart';
import 'package:user_manager/states/user/user_event.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class ScheduleService {
    // static final storage = FlutterSecureStorage(); 
    
    // final String userDatabaseId = "6828ab9b03c0405a8090d9e99dd3881b";
    final String scheduleDatabaseId = NotionDatabase.scheduleId;
    
    NotionClient client = NotionClient();
    

    
   /// user list
    Future<List<SchedulePrimary>> index(query)async{
      // final String userDatabaseId = await storage.read(key : 'database').toString();
    
      final result = await client.databases.query(scheduleDatabaseId,query: query);
      final Map<String,User> tmpUser = {};
      final List<SchedulePrimary> schedules = [];
      final results = result['results'];   


      for(int i=0; i<results.length; i++){
        
        String id = results[i]['id'];

        final Map result = results[i];
        var property = result['properties'];

        final List userIdResponse = property['user_id']['rich_text'];
        String userId = '';
        if(userIdResponse.length != 0){
          userId = userIdResponse[0]['text']['content'];
        }
        final User? checkUser = tmpUser[userId];
        final User user;
        if(checkUser == null){
           user = await UserService().find(userId);
           tmpUser[userId] = user;
        }else{
            user = checkUser;
        }
    
        

        final List descriptionResponse = property['description']['rich_text'];
        String description = '';
        if(descriptionResponse.length != 0){
          description = descriptionResponse[0]['text']['content'];
        }

        final DateTime startDate = DateTime.parse(property['date']['date']['start'].toString());
        final DateTime endDate = DateTime.parse(property['date']['date']['end'].toString());
        print("startDate ${startDate}");



        schedules.add(SchedulePrimary(id : id, schedule: Schedule(user : user, eventName: description, from: startDate ,to : endDate, background: Color(int.parse(user.color)))));
      }
      inspect(schedules);
      return schedules;
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



        String phoneNumber = property['phone_number']['phone_number'] ?? "-";   
        final User user = User(id : id, name : name, phoneNumber: phoneNumber, description: description, jobCount: jobCount);
        return user;
    }


    Future<SchedulePrimary> create(Schedule data) async {
      print("schedule Property create");
      inspect(data);
      final result = await client.pages.create({
          "parent": {
              "database_id": scheduleDatabaseId
          },
          "properties": {
              "description": {
                  "rich_text": [
                      {
                          "text": {
                              "content": data.eventName
                          }
                      }
                  ]
              },
              "date": {
                  "date": {
                    "start" : data.from.toString(),
                    "end" : data.to.toString()
                  }
              },
              "user_id" : {
                "rich_text": [
                      {
                          "text": {
                              "content": data.user.id
                          }
                      }
                  ]
              }
          }
      });
      
      final String id = result['id'];
      return SchedulePrimary(id: id, schedule: data);
    }

    Future<SchedulePrimary> update(SchedulePrimary data) async {
      final update = await client.pages.update(data.id,{
        "parent": {
          "database_id": scheduleDatabaseId
        },
        "properties": {
          "description": {
            "rich_text": [
              {
                "text": {
                  "content": data.schedule.eventName
                }
              }
            ]
          },
          "date": {
            "date": {
              "start" : data.schedule.from.toString(),
              "end" : data.schedule.to.toString()
            }
          },
          "user_id" : {
            "rich_text": [
              {
                "text": {
                  "content": data.schedule.user.id
                }
              }
            ]
          }
        }
      });
      print("update ${update}");
      return data;
    }

    

}