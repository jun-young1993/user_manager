import 'dart:developer';

import 'package:user_manager/domain/entities/schedule.dart';

enum CalendarStateStatus {
  initial,
  loading,
  loadSuccess,
  loadFailure,
  loadingMore,
  loadMoreSuccess,
  loadMoreFailure,
}

class CalendarState {
  final CalendarStateStatus status;
  final List<SchedulePrimary> schedules;
  final Exception? error;

  const CalendarState._({
    this.status = CalendarStateStatus.initial,   
    this.schedules = const [],
    this.error,
  });

  const CalendarState.initial() : this._();

  CalendarState asloading() {
    return copyWith(
      status : CalendarStateStatus.loading
    );
  }
  CalendarState asLoadSuccess(List<SchedulePrimary> schedules) {
    print("asLoadSuccess");
      inspect(schedules);
      return copyWith(
        status: CalendarStateStatus.loadSuccess,
        schedules: schedules
      );
  }

  CalendarState asLoadFailure(Exception e) {
        return copyWith(
          status: CalendarStateStatus.loadFailure,
          error: e,
        );
  }

  CalendarState copyWith({
      CalendarStateStatus? status,
      List<SchedulePrimary>? schedules,
      Exception? error,
    }) {
      return CalendarState._(
          status: status ?? this.status,
          schedules: schedules ?? this.schedules,
          error: error ?? this.error,
      );
  }
}