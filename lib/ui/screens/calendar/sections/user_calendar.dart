part of '../calendar.dart';

class _UserCalendar extends StatefulWidget {
  const _UserCalendar();

  @override
  State<StatefulWidget> createState() => _UserCalendarState();
}

class _UserCalendarState extends State<_UserCalendar> {
  final GlobalKey<NestedScrollViewState> _scrollKey = GlobalKey();

  Widget build(BuildContext context){
    return NestedScrollView(
        key : _scrollKey,
        headerSliverBuilder: (_, __) => [
            MainSliverAppBar(
              title : CategoryNames.calendar,
              context: context,
            ),
        ],
        body : SfCalendar(
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
          dataSource: MeetingDataSource(_getDataSource()),
        )
    );
  }
}

List<Meeting> _getDataSource() {
  final List<Meeting> meetings = <Meeting>[];
  final DateTime today = DateTime.now();
  print("today.year ${today.year}");
  print("today.month ${today.month}");
  print("today.day ${today.day}");
  final DateTime startTime =
  DateTime(today.year, today.month, today.day, 9, 0, 0);
  final DateTime endTime = startTime.add(const Duration(hours: 2));
  meetings.add(Meeting(
      '', startTime, endTime, const Color(0xFF0F8644), false));
  return meetings;
}


class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}