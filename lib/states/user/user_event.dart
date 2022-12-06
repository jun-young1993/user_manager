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