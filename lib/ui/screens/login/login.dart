import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:user_manager/configs/constants.dart';
import 'package:user_manager/configs/images.dart';
import 'package:user_manager/configs/statics/notion_database.dart';
import 'package:user_manager/domain/entities/database.dart';
import 'package:user_manager/routes.dart';
import 'package:user_manager/service/database_service.dart';
import 'package:user_manager/states/login/login_bloc.dart';
import 'package:user_manager/states/login/login_event.dart';
import 'package:user_manager/states/login/login_selector.dart';
import 'package:user_manager/states/login/login_state.dart';
import 'package:user_manager/ui/widgets/category_background.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  
  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // @override
  // void initState() {
  //   super.initState();
  // }
  LoginBloc get loginBloc => context.read<LoginBloc>();
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
      print("build complete");
      print(context);
    
      _asyncMethod();
    });
  }

  void _asyncMethod() async {
    databaseInfos = await storage.read(key: 'database');
    // _moveHome();
    if (databaseInfos != null) {
      inspect(jsonDecode(databaseInfos));
      NotionDatabase.userId = jsonDecode(databaseInfos)["userId"];
      NotionDatabase.schemaId = jsonDecode(databaseInfos)["schemaId"];
      NotionDatabase.scheduleId = jsonDecode(databaseInfos)["scheduleId"];
      
    }
    // else{
    //   final databaseIds = await DatabaseService().create(
    //     DatabaseProperty(name: "단화실TEST", phoneNumber: "###-####-####"));

    //     await storage.write(key: "database", value: jsonEncode(databaseIds));
    //     _asyncMethod();
    // }
  }

  // void _moveHome() {
  //   print('move home');
  //   // AppNavigator.pop();
  //   // AppNavigator.push(Routes.home);
  // }

  @override
  Widget build(BuildContext context) {
    return CategoryBackground(
      child: Center(
      //     child: TextButton(
      //   onPressed: () async {
      //     final databaseIds = await DatabaseService().create(
      //         DatabaseProperty(name: "단화실TEST", phoneNumber: "###-####-####"));

      //     await storage.write(key: "database", value: jsonEncode(databaseIds));
      //     _asyncMethod();
      //   },
      //   child: Text("시작하기"),
      // )
      
  
        child : LoginStateStatusSelector((status){
          print('status');
          print(status);
          switch(status) {
            case LoginStateStatus.loading :
              return _buildLoading();
            case LoginStateStatus.loadSuccess :
              return Container();
            default:
              return _buildInit();
          }
    
        })
        
      )
    );
  }
  Widget _buildLoading() {
    return Center(child: Image(image: AppImages.loader));
  }
  Widget _buildInit(){
    return TextButton(
      child: Text("카카오 로그인"),
      onPressed: () async {
        print("카카오 로그인 클릭");
        loginBloc.add(LoginStarted());
        // 카카오 로그인 구현 예제

// 카카오톡 실행 가능 여부 확인
// 카카오톡 실행이 가능하면 카카오톡으로 로그인, 아니면 카카오계정으로 로그인
        
      }
    );
  }
}
