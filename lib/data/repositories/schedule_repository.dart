import 'package:user_manager/domain/entities/schedule.dart';
import 'package:user_manager/service/schedule_service.dart';

abstract class ScheduleRepository {
  Future<SchedulePrimary> create(Schedule schedule);
  Future<List<SchedulePrimary>> index(query);
  Future<SchedulePrimary> update(SchedulePrimary schedule);
}

class ScheduleDefaultRepository extends ScheduleRepository {
  Future<SchedulePrimary> create (Schedule schedule) async {
    return ScheduleService().create(schedule);
  }
  Future<List<SchedulePrimary>> index(query) async {
    return ScheduleService().index(query);
  }
  Future<SchedulePrimary> update(SchedulePrimary schedule) async {
    return ScheduleService().update(schedule);
  }
}