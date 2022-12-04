import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_manager/states/user/user_bloc.dart';
import 'package:user_manager/states/user/user_state.dart';

class UserStateSelector<T> extends BlocSelector<UserBloc, UserState, T> {
  UserStateSelector({
    required T Function(UserState) selector,
    required Widget Function(T) builder,
  }) : super( selector: selector,
              builder: (_, value) => builder(value),
            );
}

// class UserStatetatusSelector extends