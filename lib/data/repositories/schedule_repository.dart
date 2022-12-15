import 'package:user_manager/domain/entities/schedule.dart';
import 'package:user_manager/service/schedule_service.dart';

abstract class ScheduleRepository {
  Future<SchedulePrimary> create(Schedule schedule);
  Future<List<SchedulePrimary>> index(query);
}

class ScheduleDefaultRepository extends ScheduleRepository {
  Future<SchedulePrimary> create (Schedule schedule) async {
    return ScheduleService().create(schedule);
  }
  Future<List<SchedulePrimary>> index(query) async {
    return ScheduleService().index(query);
  }
}