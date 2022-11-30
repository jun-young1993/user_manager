import 'package:user_manager/lib/notion/notion_client.dart';
class UserService {
   final String userDatabaseId = "6828ab9b03c0405a8090d9e99dd3881b";
    NotionClient client = NotionClient();

   Future index()async{
    final result = await client.databases.query(userDatabaseId);
    
    // return result;
    // .then((result) => {
        final List users = [];
        final results = result['results'];
        for(int i=0; i<results.length; i++){
          
             String id = results[i]['id'];
             final List titleResponse = results[i]['properties']['name']['title'];
             String name = "no name";
             if(titleResponse.length != 0){
                 name = titleResponse[0]['text']['content'];
              }
            
                
                
          users.add({
            "id" : id,
            "name" : name
          });
        }
        return users;
    //  });
   }
}