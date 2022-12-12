import 'package:user_manager/domain/entities/user.dart';

abstract class UserEvent {
  const UserEvent();
}

class UserLoadStarted extends UserEvent{
  final bool loadAll;

  const UserLoadStarted({this.loadAll = false});
}

class UserLoadMoreStarted extends UserEvent{}

class UserSelectChanged extends UserEvent {
  final String id;
  
  const UserSelectChanged({required this.id});
}


class UserCreated extends UserEvent {
  final UserProperty user;

  const UserCreated(this.user);


}

class CurrentUserUpdate extends UserEvent {
  final User user;
  const CurrentUserUpdate(this.user);
}