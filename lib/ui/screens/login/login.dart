import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:user_manager/configs/constants.dart';
import 'package:user_manager/configs/statics/notion_database.dart';
import 'package:user_manager/domain/entities/database.dart';
import 'package:user_manager/routes.dart';
import 'package:user_manager/service/database_service.dart';
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
    databaseInfos = await storage.read(key: 'database');

    if (databaseInfos != null) {
      inspect(jsonDecode(databaseInfos));
      NotionDatabase.userId = jsonDecode(databaseInfos)["userId"];
      NotionDatabase.schemaId = jsonDecode(databaseInfos)["schemaId"];
      NotionDatabase.scheduleId = jsonDecode(databaseInfos)["scheduleId"];
      _moveHome();
    }
  }

  void _moveHome() {
    AppNavigator.pop();
    AppNavigator.push(Routes.home);
  }

  @override
  Widget build(BuildContext context) {
    return CategoryBackground(
      child: Center(
          child: TextButton(
        onPressed: () async {
          final databaseIds = await DatabaseService().create(
              DatabaseProperty(name: "단화실TEST", phoneNumber: "###-####-####"));

          await storage.write(key: "database", value: jsonEncode(databaseIds));
          _asyncMethod();
        },
        child: Text("시작하기"),
      )
//       TextButton(
//           child: Text("카카오 로그인"),
//           onPressed: () async {
//             print("카카오 로그인 클릭");
//             // 카카오 로그인 구현 예제

// // 카카오톡 실행 가능 여부 확인
// // 카카오톡 실행이 가능하면 카카오톡으로 로그인, 아니면 카카오계정으로 로그인
//             if (await isKakaoTalkInstalled()) {
//               try {
//                 await UserApi.instance.loginWithKakaoTalk();
//                 print('카카오톡으로 로그인 성공');
//               } catch (error) {
//                 print('카카오톡으로 로그인 실패 $error');

//                 // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
//                 // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
//                 if (error is PlatformException && error.code == 'CANCELED') {
//                   return;
//                 }
//                 // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
//                 try {
//                   await UserApi.instance.loginWithKakaoAccount();
//                   print('카카오계정으로 로그인 성공');
//                 } catch (error) {
//                   print('카카오계정으로 로그인 실패 $error');
//                 }
//               }
//             } else {
//               try {
//                 await UserApi.instance.loginWithKakaoAccount();
//                 print('카카오계정으로 로그인 성공');
//               } catch (error) {
//                 print('카카오계정으로 로그인 실패 $error');
//               }
          // }
          // }
          ),
    );
  }
}
