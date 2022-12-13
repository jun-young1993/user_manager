import 'package:user_manager/domain/entities/schedule.dart';

abstract class ScheduleRepository {
  Future<List<Schedule>> get();
}

// class ScheduleDefaultRepository extends ScheduleRepository {
//   Future<List<Schedule>> get () async {
    
//   }
// }