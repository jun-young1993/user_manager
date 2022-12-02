import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_manager/states/user/user_event.dart';
import 'package:user_manager/states/user/user_state.dart';

class UserBloc extends Bloc<UserEvent,UserState> {
    UserBloc() : super(UserState());
}