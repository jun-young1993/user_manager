import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_manager/states/user/user_bloc.dart';
import 'package:user_manager/states/user/user_state.dart';
import 'package:user_manager/states/user/user_state.dart';
import 'package:user_manager/domain/entities/user.dart';
class UserStateSelector<T> extends BlocSelector<UserBloc, UserState, T> {
  UserStateSelector({
    required T Function(UserState) selector,
    required Widget Function(T) builder,
  }) : super( selector: selector,
              builder: (_, value) => builder(value),
            );
}

class UserStateStatusSelector extends UserStateSelector<UserStateStatus> {
  UserStateStatusSelector(Widget Function(UserStateStatus) builder)
  : super(
    selector: (state) => state.status,
    builder: builder
  );
}

class NumberOfUsersSelector extends UserStateSelector<int> {
  NumberOfUsersSelector(Widget Function(int) builder)
    :super(
      selector : (state) => state.users.length,
      builder: builder
    );
}

class UserSelector extends UserStateSelector<UserSelectorState> {
  UserSelector(int index, Widget Function(User, bool) builder)
    : super(
        selector : (state) =>UserSelectorState(
          state.users[index],
          state.selectedUserIndex == index
        ),
        builder : (value) => builder(value.user, value.selected)
    );
}

class CurrentUserSelector extends UserStateSelector<User> {
  CurrentUserSelector(Widget Function(User) builder)
      : super(
          selector: (state) => state.selectedUser,
          builder: builder,
        );
}



class UserSelectorState {
  final User user;
  final bool selected;

  const UserSelectorState(this.user, this.selected);

  @override
  bool operator ==(Object other) => 
    other is UserSelectorState && user == other.user && selected == other.selected;
}