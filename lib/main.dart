import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_manager/data/repositories/user_repository.dart';

import 'package:user_manager/states/user/user_bloc.dart';
import 'package:user_manager/app.dart';

import 'package:user_manager/states/theme/theme_cubit.dart';
void main() async {
    WidgetsFlutterBinding.ensureInitialized();

  
  runApp(
    MultiRepositoryProvider(
      providers : [
        RepositoryProvider<UserRepository>(create : (context) => UserDefaultRepository())
      ],
      child : MultiBlocProvider(
        providers : [
          BlocProvider<UserBloc>(
            create: (context) => UserBloc(context.read<UserRepository>()),
          ),
          BlocProvider<UserBloc>(
            create: (context) => UserBloc(context.read<UserRepository>()),
          ),
          BlocProvider<ThemeCubit>(
            create: (context) => ThemeCubit(),
          )
        ],
        child : UserManagerApp()
      )
    )
  );
}
