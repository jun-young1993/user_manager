import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:user_manager/data/repositories/schedule_repository.dart';
import 'package:user_manager/domain/entities/schedule.dart';
import 'package:user_manager/states/schedule/schedule_event.dart';
import 'package:user_manager/states/schedule/schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  final ScheduleRepository _scheduleRepository;

  ScheduleBloc(this._scheduleRepository) : super(ScheduleState.initial()) {
    on<ScheduleLoadStarted>(_onLoadStarted,
        transformer: (events, mapper) => events.switchMap(mapper));
    on<ScheduleBeforeLoadStarted>(_onBeforeLoadStarted,
        transformer: (events, mapper) => events.switchMap(mapper));
    on<ScheduleAfterLoadStarted>(_onAfterLoadStarted,
        transformer: (events, mapper) => events.switchMap(mapper));
    on<ScheduleCreated>(_onCreated);
    on<ScheduleUpdated>(_onUpdated);
  }

  void _onBeforeLoadStarted(
      ScheduleBeforeLoadStarted event, Emitter<ScheduleState> emit) async {
    try {
      final DateTime currentDate = DateTime.now();
      emit(state.asloading());
      final List<SchedulePrimary> schedules = await _scheduleRepository.index({
        "filter": {
          "and": [
            {
              "property": "user_id",
              "rich_text": {"equals": event.user.id}
            },
            {
              "property": "date",
              "date": {
                "on_or_before":
                    "${currentDate.year}-${currentDate.month}-${currentDate.day}"
              }
            }
          ]
        }
      });
      print("_onLoadStarted");
      inspect(schedules);
      emit(state.asLoadSuccess(schedules, canLoadMore: false));
    } on Exception catch (e) {
      emit(state.asLoadFailure(e));
    }
  }

  void _onAfterLoadStarted(
      ScheduleAfterLoadStarted event, Emitter<ScheduleState> emit) async {
    try {
      final DateTime currentDate = DateTime.now();
      emit(state.asloading());
      final List<SchedulePrimary> schedules = await _scheduleRepository.index({
        "filter": {
          "and": [
            {
              "property": "user_id",
              "rich_text": {"equals": event.user.id}
            },
            {
              "property": "date",
              "date": {
                "on_or_after":
                    "${currentDate.year}-${currentDate.month}-${currentDate.day}"
              }
            },
          ]
        }
      });
      print("_onLoadStarted");
      inspect(schedules);
      emit(state.asLoadSuccess(schedules, canLoadMore: false));
    } on Exception catch (e) {
      emit(state.asLoadFailure(e));
    }
  }

  void _onLoadStarted(
      ScheduleLoadStarted event, Emitter<ScheduleState> emit) async {
    try {
      emit(state.asloading());
      final List<SchedulePrimary> schedules = await _scheduleRepository.index({
        "filter": {
          "property": "user_id",
          "rich_text": {"equals": event.user.id}
        }
      });
      print("_onLoadStarted");
      inspect(schedules);
      emit(state.asLoadSuccess(schedules, canLoadMore: false));
    } on Exception catch (e) {
      emit(state.asLoadFailure(e));
    }
  }

  void _onCreated(ScheduleCreated event, Emitter<ScheduleState> emit) async {
    try {
      final Schedule schedule = event.schedule;
      emit(state.asloading());
      final SchedulePrimary create = await _scheduleRepository.create(schedule);

      final List<SchedulePrimary> initSchedules = state.schedules.toList();
      initSchedules.insert(0, create);
      // initSchedules.map((e) => e.setUser(user));
      inspect(initSchedules);
      // state.schedules.insert(0,schedule);
      emit(state.asLoadSuccess(initSchedules));
    } on Exception catch (e) {
      emit(state.asLoadFailure(e));
    }
  }

  void _onUpdated(ScheduleUpdated event, Emitter<ScheduleState> emit) async {
    print('before try');
    try {
      print('before updated');
      emit(state.asloading());

      final SchedulePrimary schedule = event.schedule;
      print("schedule.schedule.eventName ${schedule.schedule.eventName}");
      final scheduleIndex = state.schedules.indexWhere(
        (sch) => sch.id == schedule.id,
      );
      //
      final SchedulePrimary update = await _scheduleRepository.update(schedule);
      print("update ${update}");
      // print('after updated');
      state.schedules[scheduleIndex] = update;
      emit(state.asLoadSuccess(state.schedules));
    } on Exception catch (e) {
      emit(state.asLoadFailure(e));
    }
  }
}
