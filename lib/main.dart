import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_manager/data/repositories/user_repository.dart';
import 'package:user_manager/main_container.dart';
import 'package:user_manager/service/user_service.dart';
import 'package:user_manager/states/user/user_bloc.dart';
import 'package:user_manager/app.dart';
void main() {
    WidgetsFlutterBinding.ensureInitialized();

  
  runApp(
    MultiRepositoryProvider(
      providers : [
        RepositoryProvider<UserRepository>(create : (context) => UserDefaultRepository())
      ],
      child : MultiBlocProvider(
        providers : [
          BlocProvider<UserBloc>(
            create: (context) => UserBloc(),
          ),
        ],
        child : UserManagerApp()
      )
    )
  );
}
