
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:user_manager/data/repositories/schedule_repository.dart';
import 'package:user_manager/domain/entities/schedule.dart';
import 'package:user_manager/service/schedule_service.dart';
import 'package:user_manager/states/schedule/schedule_event.dart';
import 'package:user_manager/states/schedule/schedule_state.dart';
class ScheduleBloc extends Bloc<ScheduleEvent,ScheduleState> {
  final ScheduleRepository _scheduleRepository;
  ScheduleBloc(this._scheduleRepository) : super(ScheduleState.initial()){
    on<ScheduleLoadStarted>(
           _onLoadStarted, 
        transformer : (events, mapper) => events.switchMap(mapper)
    );
    on<ScheduleCreated>(_onCreated);
  }

  void _onLoadStarted(ScheduleLoadStarted event, Emitter<ScheduleState> emit) async {
    try{
      emit(state.asloading());
      final List<SchedulePrimary> schedules = await _scheduleRepository.index({
        "filter" : {
          "property" : "user_id",
          "rich_text" : {
            "equals" : event.user.id
          }
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
    try{
      
      final  Schedule schedule = event.schedule;
      emit(state.asloading());
      final SchedulePrimary create = await _scheduleRepository.create(schedule);
      

      
      
      final List<SchedulePrimary> initSchedules = state.schedules.toList();
      initSchedules.insert(0,create);
      
      inspect(initSchedules);
      // state.schedules.insert(0,schedule);
      emit(state.asLoadSuccess(state.schedules));
      emit(state.copyWith(schedules: initSchedules));
      
    } on Exception catch (e){
        print(e);
    }
  }
}