import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:user_manager/configs/constants.dart';
import 'package:user_manager/configs/statics/notion_database.dart';
import 'package:user_manager/domain/entities/database.dart';
import 'package:user_manager/routes.dart';
import 'package:user_manager/service/database_service.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key : key);

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}


class _LoginScreenState extends State<LoginScreen> {
  // @override
  // void initState() {
  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  // }
  static final storage = FlutterSecureStorage(); 
  dynamic databaseInfos = '';
  @override
  void initState() {
        super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  void _asyncMethod() async {
    // await storage.delete(key: 'database');
      
     databaseInfos = await storage.read(key : 'database');

    
    if(databaseInfos != null){
      inspect(jsonDecode(databaseInfos));
      NotionDatabase.userId = jsonDecode(databaseInfos)["userId"];
      NotionDatabase.schemaId = jsonDecode(databaseInfos)["schemaId"];
      NotionDatabase.scheduleId =  jsonDecode(databaseInfos)["scheduleId"];
      _moveHome();
    }

  }

  void _moveHome() {
      AppNavigator.pop();
      AppNavigator.push(Routes.home);
  }

  @override
  Widget build(BuildContext context){
    return TextButton(
      onPressed:  () async {
        final databaseIds = await DatabaseService().create(DatabaseProperty(name : "단화실TEST", phoneNumber : "###-####-####"));
      
        await storage.write(
          key : "database",
          value: jsonEncode(databaseIds)
        );
        _asyncMethod();
        
      },
      child : Text("시작하기"),
    );
  }

}