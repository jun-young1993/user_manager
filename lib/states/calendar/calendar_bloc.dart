import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:user_manager/data/repositories/schedule_repository.dart';
import 'package:user_manager/domain/entities/schedule.dart';
import 'package:user_manager/states/calendar/calendar_event.dart';
import 'package:user_manager/states/calendar/calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  final ScheduleRepository _scheduleRepository;
  CalendarBloc(this._scheduleRepository) : super(CalendarState.initial()){
    on<CalendarLoadStarted>(
           _onLoadStarted, 
        transformer : (events, mapper) => events.switchMap(mapper)
    );
  }

  void _onLoadStarted(CalendarLoadStarted event, Emitter<CalendarState> emit) async {
    try{
      emit(state.asloading());
        print(event.from.toString());
        print(event.to.toString());
      final List<SchedulePrimary> schedules =  await _scheduleRepository.index({
          "filter" : {
              "and" : [
                  {
                      "property" : "date",
                      "date" : {
                          "on_or_after" : "${event.from.year}-${event.from.month}-${event.from.day}"
                      }
                  },{
                      "property" : "date",
                      "date" : {
                          "on_or_before" : "${event.to.year}-${event.to.month}-${event.to.day}"
                      }
                  }
              ]
              
          }
      });
      print("onLoADsTARTED");
      inspect(schedules);
      emit(state.asLoadSuccess(schedules));
    } on Exception catch(e) {
      emit(state.asLoadFailure(e));
    }

  }
}