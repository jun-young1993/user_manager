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
  @override
  void initState(){

    super.initState();
    
  }

  @override
  Widget build(BuildContext context){
      
    
  
    return NestedScrollView(
        key : _scrollKey,
        headerSliverBuilder: (_, __) => [
            MainSliverAppBar(
              title : CategoryNames.calendar,
              context: context,
            ),
        ],
        body :CalendarsSelector((schedules){
          print("calendar Selector");
          inspect(schedules);
         return SfCalendar(
          onViewChanged: (ViewChangedDetails details) {
            List<DateTime> dates = details.visibleDates;
            calendarBloc.add(CalendarLoadStarted(from: dates[0],to:dates[0]));
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
      })
    );
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
    return schedule.schedule.eventName;
  }

  @override
  Color getColor(int index) {
    final SchedulePrimary schedule = appointments![index];
    return schedule.schedule.background ?? UserColor.defaultColor;
  }

  @override
  bool isAllDay(int index) {
    final SchedulePrimary schedule = appointments![index];
    return schedule.schedule.isAllDay;
  }
}
