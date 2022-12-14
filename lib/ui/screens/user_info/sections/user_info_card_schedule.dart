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
class _UserSchedule extends StatefulWidget{
  final User user;

  const _UserSchedule(this.user);

  @override
  State<StatefulWidget> createState() => _UserScheduleState();
}



class _UserScheduleState extends State<_UserSchedule> {
  
  User get user => widget.user;
  
    // UserBloc get userBloc => context.read<UserBloc>();
  ScheduleBloc get scheduleBloc => context.read<ScheduleBloc>();
  // UserBloc get userBloc => context.read<UserBloc>();
  @override
  void initState(){
    super.initState();

    scheduleBloc.add(ScheduleLoadStarted(user : user));
  }

  @override
  Widget build(BuildContext context){
    

    final slideController = UserInfoStateProvider.of(context).slideController;
    var themeCubit = BlocProvider.of<ThemeCubit>(context, listen: true);
    var isDark = themeCubit.isDark;
    // return CurrentUserSelector((user) {
        
      return AnimatedBuilder(
              animation: slideController, 
              builder: (context, child) {
                final scrollable = slideController.value.floor() == 1;

                return SingleChildScrollView(
                        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 27),
                        physics: scrollable ? BouncingScrollPhysics() : NeverScrollableScrollPhysics(),
                        child: child,
                ); 
              },
              child : Column(
                children : <Widget>[
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
                    child : Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _Label("일정추가",isDark),
                            ],
                          )
                        ),
                        Expanded(
                          child : Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: (){
                                  final DateTime today = DateTime.now();
                                  final DateTime startTime =
                                  DateTime(today.year, today.month, today.day, 9, 0, 0);
                                  final DateTime endTime = startTime.add(const Duration(hours: 2));
                                  final Schedule schedule = Schedule(
                                    user:user,
                                    eventName:"no event",
                                    from : startTime,
                                    to :endTime,
                                    background : Color(0xFF0F8644),
                                  );
                                  scheduleBloc.add(ScheduleCreated(schedule));
                                }, 
                                icon: Icon(Icons.add)
                              )
                            ],
                          )
                        )
                      ],
                    )
                  ),
                  SizedBox(height: 10,),
                  Container(
                    child : ScheduleStateStatusSelector((status){
                      print("schedule state status ${status} ${ScheduleStateStatus.loading}");
                      // return _buildLoading();
                        switch(status){
                          case ScheduleStateStatus.loading:
                            return _buildLoading();
                          case ScheduleStateStatus.loadSuccess:
                          case ScheduleStateStatus.loadMoreSuccess:
                          case ScheduleStateStatus.loadingMore:
                            return _buildGrid(isDark);
                          default:
                            return Container();
                        }
                    })
                  )
                ]
              )
            );
     
    
    // });

  }

  Widget _buildLoading() {
    return Center(
      child : Image(image: AppImages.loader)
    );
  }
    
    Widget _buildGrid(isDark) {
    
      return SchedulesSelector((schedules) {
        // print("schedules");
        // print(schedules);
        
        // schedules!.map((schedule) {
        //   scheduleConrainer.add(Container());
        // });
        return Column(
          children: [
            ...schedules!.map((schedule) => 
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
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
                    child : Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _Label(schedule.eventName,isDark),
                              SizedBox(height: 10,),
                              _Label("${schedule.from.year}-${schedule.from.month}-${schedule.from.day}", isDark),
                              SizedBox(height: 10,),
                              _Label("${schedule.from.hour}:${schedule.from.minute} ~ ${schedule.to.hour}:${schedule.to.minute}",isDark)
                              // _Label(schedule.user.name,isDark)
                            ],
                          )
                        ),
                      ],
                    )
                  ),
                  SizedBox(height: 10,)
                ],
              )
            )
          ],
        );
        // return Container(
        //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        //         decoration: BoxDecoration(
        //           borderRadius: BorderRadius.circular(12),
        //           color: Theme.of(context).backgroundColor,
        //           boxShadow: [
        //             BoxShadow(
        //               color: Colors.black.withOpacity(0.12),
        //               offset: Offset(0, 8),
        //               blurRadius: 23,
        //             )
        //           ],
        //         ),
        //         child : Row(
        //           mainAxisSize: MainAxisSize.max,
        //           children: [
        //             Expanded(
        //               child : Column(
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 children: [
        //                   _Label("일정추가",isDark),
        //                 ],
        //               )
        //             ),
        //             Expanded(
        //               child : Column(
        //                 crossAxisAlignment: CrossAxisAlignment.end,
        //                 children: [
        //                   IconButton(
        //                     onPressed: (){
        //                       final DateTime today = DateTime.now();
        //                       final DateTime startTime =
        //                       DateTime(today.year, today.month, today.day, 9, 0, 0);
        //                       final DateTime endTime = startTime.add(const Duration(hours: 2));
        //                       final Schedule schedule = Schedule(
        //                         user:user,
        //                         eventName:"no event",
        //                         from : startTime,
        //                         to :endTime,
        //                         background : Color(0xFF0F8644),
        //                       );
        //                       scheduleBloc.add(ScheduleCreated(schedule));
        //                     }, 
        //                     icon: Icon(Icons.add)
        //                   )
        //                 ],
        //               )
        //             )
        //           ],
        //         )
        // );
      });
  }
 
}