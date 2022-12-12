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
              _UserInfoContainer(
                  children: [
                    _UserInfoContainerChildren(label: "잔여 횟수", text: user.jobCount.toString()),
                    _UserInfoContainerChildren( children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(1000.0),
                        onTap : () {
                              print("plus +1");
                              
                              userBloc.add(CurrentUserUpdate(user.plusJobCount()));
                        },
                        child: Icon(
                            Icons.arrow_circle_up_sharp,
                            size: 30.0,
                            color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 30,),
                      InkWell(
                        borderRadius: BorderRadius.circular(1000.0),
                        onTap : () {
                              print("plus +1");
                              if(user.jobCount != 0){
                                userBloc.add(CurrentUserUpdate(user.minusJobCount()));
                              }
                              
                        },
                        child: Icon(
                            Icons.arrow_circle_down_sharp,
                            size: 30.0,
                            color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 10,),
                    ]),
                  ],
                  isDark: isDark,
              )
          ]
        )
      );
    });
    
  }


 
}