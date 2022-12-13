
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_manager/states/schedule/schedule_event.dart';
import 'package:user_manager/states/schedule/schedule_state.dart';
class ScheduleBloc extends Bloc<ScheduleEvent,ScheduleState> {
  ScheduleBloc() : super(ScheduleState.initial());
}