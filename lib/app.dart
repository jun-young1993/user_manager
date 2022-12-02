import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_manager/routes.dart';
import 'package:user_manager/config/constants.dart';


/// MaterialApp
class UserManagerApp extends StatelessWidget {
    
    @override
    Widget build(BuildContext context){
    
      return MaterialApp(
        color : Colors.white,
        navigatorKey: AppNavigator.navigatorKey,
        onGenerateRoute: AppNavigator.onGenerateRoute,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        title : "UserManager",
        builder: (context, child) {
          print("[UserManagerApp Builder]");
          print("child => ${child}");
          print("context => ${context}");
          if(child == null) return SizedBox.shrink();

          final data = MediaQuery.of(context);
          final smallestSize = min(data.size.width, data.size.height);
          final textScaleFactor = min(smallestSize / AppConstants.designScreenSize.width, 1.0);
          return MediaQuery(data: data.copyWith(textScaleFactor: textScaleFactor), child: child);
        },
      );
    }
}