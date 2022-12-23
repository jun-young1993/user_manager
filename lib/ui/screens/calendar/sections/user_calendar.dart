part of '../calendar.dart';

class _UserCalendar extends StatefulWidget {
  const _UserCalendar();

  @override
  State<StatefulWidget> createState() => _UserCalendarState();
}

class _UserCalendarState extends State<_UserCalendar> {
  final GlobalKey<NestedScrollViewState> _scrollKey = GlobalKey();

  CalendarBloc get calendarBloc => context.read<CalendarBloc>();
  //  context.read(<CalendarBloc>);
  DateTime initDate = DateTime.now();
  @override
  void initState(){

    super.initState();
    
  }

  @override
  Widget build(BuildContext context){


    // calendarBloc.add(CalendarLoadStarted(from: DateTime.now(),to:DateTime.now()));
    return NestedScrollView(
        key : _scrollKey,
        headerSliverBuilder: (_, __) => [
            MainSliverAppBar(
              title : CategoryNames.calendar,
              context: context,
            ),
        ],
        body : CalendarStateSelector((state) {
          print("calendar state status selector ${state.status}");
          switch(state.status){
            case CalendarStateStatus.initial:
              return _buildCalendar(state.loadFrom);
            case CalendarStateStatus.loading:
              return _buildLoading();
            case CalendarStateStatus.loadSuccess:
            case CalendarStateStatus.loadMoreSuccess:
            case CalendarStateStatus.loadingMore:
              return _buildCalendar(state.loadFrom);
            default:
              return Container();
          }

        })
    );
  }
  Widget _buildLoading() {
    return Center(
        child : Image(image: AppImages.loader)
    );
  }



  Widget _buildCalendar(DateTime? loadFrom){
    return CalendarsSelector((schedules){
      print("calendar Selector");
      inspect(schedules);
      return SfCalendar(
          view: CalendarView.day,
          initialDisplayDate: loadFrom ?? DateTime.now(),
          onViewChanged: (ViewChangedDetails details) {
            print("details ${details}");
            List<DateTime> dates = details.visibleDates;


              // calendarBloc.add(CalendarLoadStarted(from: dates[0],to:dates[0]));
            calendarBloc.add(CalendarLoadStarted(from: dates.first, to: dates.last));

            print("on view changed ${dates}");
          },
          // view: CalendarView.week,
          onTap: (CalendarTapDetails details) {
            print("press");
            print(details.toString());
            dynamic appointment = details.appointments;
            print(appointment);
            DateTime date = details.date!;
            print(date);
            CalendarElement element = details.targetElement;
            print(element);
          },
          dataSource: ScheduleDataSource(schedules ?? [])

      );
    });
  }
}



class ScheduleDataSource extends CalendarDataSource {
  ScheduleDataSource(List<SchedulePrimary> source) {
    appointments = source;
  }
    
  @override
  DateTime getStartTime(int index) {
    final SchedulePrimary schedule = appointments![index];
    final DateTime startTime = schedule.schedule.from;    
    return DateTime(startTime.year,startTime.month,startTime.day,startTime.hour,startTime.minute,startTime.second);
  }

  @override
  DateTime getEndTime(int index) {
    final SchedulePrimary schedule = appointments![index];
    final DateTime endTime = schedule.schedule.to;
    return DateTime(endTime.year,endTime.month,endTime.day,endTime.hour,endTime.minute,endTime.second);
  }

  @override
  String getSubject(int index) {
    final SchedulePrimary schedule = appointments![index];
    return "${schedule.schedule.user.name}\r\n${schedule.schedule.eventName}\r\n";
  }

  @override
  Color getColor(int index) {
    final SchedulePrimary schedule = appointments![index];
    return Color(int.parse(schedule.schedule.user.color));
  }

  @override
  bool isAllDay(int index) {
    final SchedulePrimary schedule = appointments![index];
    return schedule.schedule.isAllDay;
  }

  @override
  Future<void> handleLoadMore(DateTime startDate, DateTime endDate) async {
    print("=== ${startDate} - ${endDate}");
    await Future<void>.delayed(const Duration(seconds: 3));

    notifyListeners(CalendarDataSourceAction.add,[]);
  }
}
