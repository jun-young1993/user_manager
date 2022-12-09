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
        body : SfCalendar()
    );
  }
}