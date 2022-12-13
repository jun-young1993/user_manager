import 'package:user_manager/domain/entities/schedule.dart';

enum ScheduleStateStatus {
  initial,
  loading,
  loadSuccess,
  loadFailure,
  loadingMore,
  loadMoreSuccess,
  loadMoreFailure,
}
class ScheduleState {
    final ScheduleStateStatus status;
    final List<Schedule> schedules;
    final int selectedScheduleIndex;
    final int page;
    final Exception? error;
    final bool canLoadMore;

    Schedule get selectedSchedule => schedules[selectedScheduleIndex];

    const ScheduleState._({
      this.status = ScheduleStateStatus.initial,   
      this.schedules = const [],
      this.selectedScheduleIndex = 0,
      this.page = 1,
      this.canLoadMore = true,
      this.error,
    });

    const ScheduleState.initial() : this._();
    

    ScheduleState asloading() {
      return copyWith(
        status : ScheduleStateStatus.loading
      );
    }

    ScheduleState asLoadSuccess(List<Schedule> schedules, {bool canLoadMore = true}) {
      return copyWith(
        status: ScheduleStateStatus.loadSuccess,
        schedules: schedules,
        page: 1,
        canLoadMore: canLoadMore,
      );
    }

    ScheduleState asLoadFailure(Exception e) {
        return copyWith(
          status: ScheduleStateStatus.loadFailure,
          error: e,
        );
    }


    ScheduleState copyWith({
      ScheduleStateStatus? status,
      List<Schedule>? schedules,
      int? selectedScheduleIndex,
      int? page,
      bool? canLoadMore,
      Exception? error,
    }) {
      return ScheduleState._(
          status: status ?? this.status,
          schedules: schedules ?? this.schedules,
          selectedScheduleIndex: selectedScheduleIndex ?? this.selectedScheduleIndex,
          page: page ?? this.page,
          canLoadMore: canLoadMore ?? this.canLoadMore,
          error: error ?? this.error,
      );
    }
}