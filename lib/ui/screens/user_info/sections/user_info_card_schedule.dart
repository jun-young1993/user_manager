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
  
  const _UserSchedule();

  @override
  State<StatefulWidget> createState() => _UserScheduleState();
}



class _UserScheduleState extends State<_UserSchedule> {
  
  
  
    UserBloc get userBloc => context.read<UserBloc>();
  // UserBloc get userBloc => context.read<UserBloc>();

  @override
  Widget build(BuildContext context){
    

    final slideController = UserInfoStateProvider.of(context).slideController;
    var themeCubit = BlocProvider.of<ThemeCubit>(context, listen: true);
    var isDark = themeCubit.isDark;
    return CurrentUserSelector((user) {
        
        return AnimatedBuilder(
        animation: slideController, 
        builder: (context, child) {
          final scrollable = slideController.value.floor() == 1;

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 19, horizontal: 27),
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
                            
                            showDialog(
                              context : context,
                              builder: (BuildContext context){
                                return AlertDialog(
                                  content : Stack(
                                    children : <Widget>[
                                      DatePickerStatefulWidget(restorationId:'main')
                                    ]
                                  )
                                );
                              },
                            );
                          }, 
                          icon: Icon(Icons.add)
                        )
                      ],
                    )
                  )
                ],
              )
            )
          ]
        )
      );
    });
    
  }


  void ShowDatePickerPop(context) {
    Future<DateTime?> selectedDate = showDatePicker(
      context: context,
      initialDate: DateTime.now(), //초기값
      firstDate: DateTime(2020), //시작일
      lastDate: DateTime(2022), //마지막일
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark(), //다크 테마
          child: child!,
        );
      },
    );

    selectedDate.then((dateTime) {
      // Fluttertoast.showToast(
      //   msg: dateTime.toString(),
      //   toastLength: Toast.LENGTH_LONG,
      //   //gravity: ToastGravity.CENTER,  //위치(default 는 아래)
      // );
    });
  }
}