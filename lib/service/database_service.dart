import 'dart:convert';

import 'package:user_manager/configs/constants.dart';
import 'package:user_manager/domain/entities/database.dart';
import 'package:user_manager/lib/notion/notion_client.dart';





class DatabaseService {
   final String databaseId = AppConstants.databaseId;
    NotionClient client = NotionClient();

    Future<Database> createSchema(DatabaseProperty data) async {
      final result = await client.pages.create({
          "parent": {
              "database_id": databaseId
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
              }
          }
      });
      
      return Database(id: result['id'], name: data.name, phoneNumber: data.phoneNumber);
    }

    
    
    Future<DatabaseId> create(DatabaseProperty data) async {
        final result  = await createSchema(data);

        final user = await client.databases.create({
            "parent": {
                "type" : "page_id",
                "page_id": result.id
            },
                "title": [
                {
                    "type": "text",
                    "text": {
                        "content": "Users",
                        "link": null
                    }
                }
            ],
            "properties": {
                        "title" : {
                            "title" : {}
                        },
                        "phone_number": {
                          "phone_number"   : {}
                        },
                        "disable": {
                            "checkbox" : {}
                        },
                        "color": {
                            "rich_text": {}
                        },
                        "name": {
                            "rich_text": {}
                        },
                        "description": {
                            "rich_text": {}
                        },
                        "job_count" : {
                          "number" : {}
                        }
                }
        });

        final schedule = await client.databases.create({
            "parent": {
                "type" : "page_id",
                "page_id": result.id
            },
                "title": [
                {
                    "type": "text",
                    "text": {
                        "content": "Schedule",
                        "link": null
                    }
                }
            ],
            "properties": {
                        "title" : {
                            "title" : {}
                        },
                        "user_id": {
                            "rich_text": {}
                        },
                        "date": {
                            "date": {}
                        },
                        "description": {
                            "rich_text": {}
                        }
                }
        });

        return DatabaseId(schemaId: result.id, userId : user['id'],scheduleId : schedule['id']);
    }
    

}