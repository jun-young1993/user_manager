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
  final Color background;
  final bool isAllDay;
}