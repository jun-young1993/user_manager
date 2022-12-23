import 'package:flutter/material.dart';
import 'package:user_manager/domain/entities/user.dart';

class Schedule {
  const Schedule({
    required this.user, 
    this.eventName = "no event", 
    required this.from, 
    required this.to, 
    required this.background, 
    this.isAllDay = false
  });

  final User user;
  final String eventName;
  final DateTime from;
  final DateTime to;
  final Color? background;
  final bool isAllDay;

  Schedule setUser(User user){
    return Schedule(user: user,eventName: eventName,from: from,to: to,background: background,isAllDay: isAllDay);
  }
  Schedule setFrom(DateTime from){

    return Schedule(user: user,eventName: eventName,from: from,to: DateTime(from.year,from.month,from.day,to.hour,to.minute,to.second),background: background,isAllDay: isAllDay);
  }
  Schedule setTo(DateTime to){
    return Schedule(user: user,eventName: eventName,from: from,to: DateTime(from.year,from.month,from.day,to.hour,to.minute,to.second),background: background,isAllDay: isAllDay);
  }

  Schedule setEventName(String eventName){
    return Schedule(user: user,eventName: eventName,from: from,to: to,background: background,isAllDay: isAllDay);
  }


}

class SchedulePrimary {
  const SchedulePrimary({
    required this.id,
    required this.schedule
  });

  final String id;
  final Schedule schedule;
  setUser(User user){
    return SchedulePrimary(id: id, schedule: schedule.setUser(user));
  }
  SchedulePrimary setSchedule(Schedule schedule){
    return SchedulePrimary(id: id, schedule: schedule);
  }
}
// class Schedule {
//   const Schedule({

//   })
// }