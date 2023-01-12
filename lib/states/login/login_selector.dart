import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_manager/states/login/login_bloc.dart';
import 'package:user_manager/states/login/login_state.dart';

class LoginSelector<T> extends BlocSelector<LoginBloc, LoginState, T> {
  LoginSelector({
    required T Function(LoginState) selector,
    required Widget Function(T) builder,
  }) : super(selector: selector, builder: (_, value) => builder(value));
}

class LoginStateStatusSelector extends LoginSelector<LoginStateStatus> {
  LoginStateStatusSelector(Widget Function(LoginStateStatus) builder) 
  : super(
    selector: (state) => state.status,
    builder : builder
  );
}