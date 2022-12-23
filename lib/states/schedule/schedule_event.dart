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

class ScheduleCreated extends ScheduleEvent {
  final Schedule schedule;
  const ScheduleCreated(this.schedule);
}

class ScheduleUpdated extends ScheduleEvent {
  final SchedulePrimary schedule;
  const ScheduleUpdated(this.schedule);
}
