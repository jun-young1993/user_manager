import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_manager/domain/entities/schedule.dart';
import 'package:user_manager/states/schedule/schedule_bloc.dart';
import 'package:user_manager/states/schedule/schedule_state.dart';

class ScheduleSelector<T> extends BlocSelector<ScheduleBloc, ScheduleState, T> {
  ScheduleSelector({
    required T Function(ScheduleState) selector,
    required Widget Function(T) builder,
  }) : super( selector : selector,
              builder : (_,value) => builder(value));
}

class ScheduleStateStatusSelector extends ScheduleSelector<ScheduleStateStatus> {
    ScheduleStateStatusSelector(Widget Function(ScheduleStateStatus) builder)
  : super(
    selector: (state) => state.status,
    builder: builder
  );
}

class SchedulesSelector extends ScheduleSelector<List<SchedulePrimary>?> {
  SchedulesSelector(Widget Function(List<SchedulePrimary>?) builder) 
    : super(
      selector : (state) => state.schedules,
       builder : builder
    );
}
