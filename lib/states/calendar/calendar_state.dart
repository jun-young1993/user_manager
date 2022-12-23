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
  final DateTime? loadFrom;
  final DateTime? loadTo;

  const CalendarState._({
    this.status = CalendarStateStatus.initial,   
    this.schedules = const [],
    this.error,
    this.loadFrom,
    this.loadTo
  });

  const CalendarState.initial() : this._();

  bool isLoaded(DateTime from, DateTime to){
    print("isLoaded this.loadFrom ${this.loadFrom}");
    print("isLoaded from ${from}");
    print("isLoaded this.loadTo ${this.loadTo}");
    print("isLoaded to ${to}");
    return ((this.loadFrom == from) && (this.loadTo == to));
  }

  CalendarState asloading(DateTime from, DateTime to) {
    return copyWith(
      status : CalendarStateStatus.loading,
      loadFrom: from,
      loadTo : to
    );
  }
  CalendarState asLoadSuccess(List<SchedulePrimary> schedules) {
    print("asLoadSuccess");
      inspect(schedules);
      return copyWith(
        status: CalendarStateStatus.loadSuccess,
        schedules: schedules,
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
      DateTime? loadFrom,
      DateTime? loadTo
    }) {
      return CalendarState._(
          status: status ?? this.status,
          schedules: schedules ?? this.schedules,
          error: error ?? this.error,
          loadFrom: loadFrom ?? this.loadFrom,
          loadTo : loadTo ?? this.loadTo
      );
  }
}