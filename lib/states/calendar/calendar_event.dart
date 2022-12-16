abstract class CalendarEvent {
  const CalendarEvent();
}

class CalendarLoadStarted extends CalendarEvent {
  final DateTime from ;
  final DateTime to;
  const CalendarLoadStarted({required this.from, required this.to});

}