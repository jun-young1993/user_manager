import 'package:user_manager/domain/entities/schedule.dart';
import 'package:user_manager/domain/entities/user.dart';

abstract class ScheduleEvent {
  const ScheduleEvent();
}

class ScheduleLoadStarted extends ScheduleEvent {
  final User user;
  final bool loadAll;

  const ScheduleLoadStarted({required this.user, this.loadAll = false});
}

class ScheduleBeforeLoadStarted extends ScheduleEvent {
  final User user;

  const ScheduleBeforeLoadStarted({required this.user});
}

class ScheduleAfterLoadStarted extends ScheduleEvent {
  final User user;

  const ScheduleAfterLoadStarted({required this.user});
}

class ScheduleCreated extends ScheduleEvent {
  final Schedule schedule;
  const ScheduleCreated(this.schedule);
}

class ScheduleUpdated extends ScheduleEvent {
  final SchedulePrimary schedule;
  const ScheduleUpdated(this.schedule);
}
