part of '../user_info.dart';

// class _Label extends Text {
//   _Label(String text, bool isDark)
//       : super(
//           text,
//           style: TextStyle(
//             color: isDark ? AppColors.whiteGrey.withOpacity(0.6) : AppColors.black.withOpacity(0.6),
//             height: 0.8,
//           ),
//         );
// }
class _UserSchedule extends StatefulWidget {
  final User user;
  final ScheduleEvent? loadEvent;
  const _UserSchedule(this.user, {this.loadEvent});

  @override
  State<StatefulWidget> createState() => _UserScheduleState();
}

class _UserScheduleState extends State<_UserSchedule> {
  User get user => widget.user;
  ScheduleEvent? get loadEvent => widget.loadEvent;
  // UserBloc get userBloc => context.read<UserBloc>();
  ScheduleBloc get scheduleBloc => context.read<ScheduleBloc>();
  UserBloc get userBloc => context.read<UserBloc>();

  // UserBloc get userBloc => context.read<UserBloc>();
  @override
  void initState() {
    super.initState();
    if (loadEvent != null) {
      scheduleBloc.add(loadEvent!);
    } else {
      scheduleBloc.add(ScheduleLoadStarted(user: user));
    }
  }

  @override
  Widget build(BuildContext context) {
    final slideController = UserInfoStateProvider.of(context).slideController;
    var themeCubit = BlocProvider.of<ThemeCubit>(context, listen: true);
    var isDark = themeCubit.isDark;
    // return CurrentUserSelector((user) {

    return AnimatedBuilder(
        animation: slideController,
        builder: (context, child) {
          final scrollable = slideController.value.floor() == 1;

          return Stack(children: [
            _buildTopMenu(isDark),
            Container(
                margin: const EdgeInsets.only(top: 33),
                padding: const EdgeInsets.all(5),
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 5),
                  physics: scrollable
                      ? BouncingScrollPhysics()
                      : NeverScrollableScrollPhysics(),
                  child: child,
                ))
          ]);
        },
        child: Column(children: <Widget>[
          Container(child: ScheduleStateStatusSelector((status) {
            print(
                "schedule state status ${status} ${ScheduleStateStatus.loading}");
            // return _buildLoading();
            switch (status) {
              case ScheduleStateStatus.loading:
                return _buildLoading();
              case ScheduleStateStatus.loadSuccess:
              case ScheduleStateStatus.loadMoreSuccess:
              case ScheduleStateStatus.loadingMore:
                return _buildGrid(isDark);
              default:
                return Container();
            }
          }))
        ]));

    // });
  }

  Widget _buildLoading() {
    return Center(child: Image(image: AppImages.loader));
  }

  Widget _buildGrid(isDark) {
    return SchedulesSelector((schedules) {
      if (schedules!.length == 0) {
        return Text("등록된 일정이 없습니다.");
      }
      return Column(
        children: [
          ...schedules!.map((schedule) => Column(
                children: [
                  Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Theme.of(context).backgroundColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.12),
                            offset: Offset(0, 8),
                            blurRadius: 23,
                          )
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _Label(schedule.schedule.eventName, isDark),
                                SizedBox(
                                  height: 10,
                                ),
                                _Label(
                                    "${schedule.schedule.from.year}-${schedule.schedule.from.month}-${schedule.schedule.from.day}",
                                    isDark),
                                SizedBox(
                                  height: 10,
                                ),
                                _Label(
                                    "${schedule.schedule.from.hour}:${schedule.schedule.from.minute} ~ ${schedule.schedule.to.hour}:${schedule.schedule.to.minute}",
                                    isDark)
                                // _Label(schedule.user.name,isDark)
                              ],
                            ),
                          ),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          final DateTime currentDateTime =
                                              DateTime.now();

                                          return ScheduleForm(
                                              schedule: schedule.schedule,
                                              onPress: (updatedSchedule) {
                                                scheduleBloc.add(
                                                    ScheduleUpdated(
                                                        schedule.setSchedule(
                                                            updatedSchedule)));
                                                // scheduleBloc.add(ScheduleCreated(schedule));
                                              },
                                              msg: "수정되었습니다.");
                                        });
                                  },
                                  icon: Icon(Icons.edit))
                            ],
                          ))
                        ],
                      )),
                  SizedBox(
                    height: 10,
                  )
                ],
              ))
        ],
      );
    });
  }

  Widget _buildTopMenu(isDark) {
    return Column(children: <Widget>[
      Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Theme.of(context).backgroundColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.12),
                offset: Offset(0, 8),
                blurRadius: 23,
              )
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              IconButton(
                  onPressed: () => {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              final DateTime currentDateTime = DateTime.now();

                              return ScheduleForm(
                                  schedule: Schedule(
                                      user: user,
                                      from: currentDateTime,
                                      to: currentDateTime
                                          .add(Duration(hours: 2)),
                                      background: Color(int.parse(user.color))),
                                  onPress: (schedule) {
                                    scheduleBloc.add(ScheduleCreated(schedule));
                                  },
                                  msg: "추가되었습니다.");
                            })
                      },
                  icon: Icon(Icons.add))
            ],
          ))
    ]);
  }
}
