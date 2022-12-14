import 'package:user_manager/domain/entities/schedule.dart';

abstract class ScheduleRepository {
  Future<Schedule> create(Schedule schedule);
}

class ScheduleDefaultRepository extends ScheduleRepository {
  Future<Schedule> create (Schedule schedule) async {
    return Future<Schedule>.delayed(Duration(seconds: 2), () => schedule);
  }
}