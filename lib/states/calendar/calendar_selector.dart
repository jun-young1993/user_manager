import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_manager/domain/entities/schedule.dart';
import 'package:user_manager/states/calendar/calendar_bloc.dart';
import 'package:user_manager/states/calendar/calendar_state.dart';

class CalendarSelector<T> extends BlocSelector<CalendarBloc, CalendarState, T> {
  CalendarSelector({
    required T Function(CalendarState) selector,
    required Widget Function(T) builder
  }) : super(selector : selector,
            builder : (_, value) => builder(value));
}


class CalendarsSelector extends CalendarSelector<List<SchedulePrimary>?> {
  CalendarsSelector(Widget Function(List<SchedulePrimary>?) builder) :
    super(
      selector : (state) => state.schedules,
      builder: builder
    );
}