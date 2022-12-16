import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_manager/data/repositories/schedule_repository.dart';
import 'package:user_manager/data/repositories/user_repository.dart';
import 'package:user_manager/states/calendar/calendar_bloc.dart';
import 'package:user_manager/states/schedule/schedule_bloc.dart';

import 'package:user_manager/states/user/user_bloc.dart';
import 'package:user_manager/app.dart';

import 'package:user_manager/states/theme/theme_cubit.dart';
void main() async {
    WidgetsFlutterBinding.ensureInitialized();

  
  runApp(
    MultiRepositoryProvider(
      providers : [
        RepositoryProvider<UserRepository>(create : (context) => UserDefaultRepository()),
        RepositoryProvider<ScheduleRepository>(create : (context) => ScheduleDefaultRepository())
      ],
      child : MultiBlocProvider(
        providers : [
          BlocProvider<UserBloc>(
            create: (context) => UserBloc(context.read<UserRepository>()),
          ),
          BlocProvider<ScheduleBloc>(
            create: (context) => ScheduleBloc(context.read<ScheduleRepository>()),
          ),
          BlocProvider<CalendarBloc>(
            create: (context) => CalendarBloc(context.read<ScheduleRepository>()),
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
