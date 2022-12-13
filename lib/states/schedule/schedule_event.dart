import 'package:user_manager/domain/entities/schedule.dart';

abstract class ScheduleEvent {
  const ScheduleEvent();
}

class UserLoadStarted extends ScheduleEvent{
  final bool loadAll;

  const UserLoadStarted({this.loadAll = false});
}

class UserLoadMoreStarted extends ScheduleEvent{}
