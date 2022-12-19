
part of '../user_info.dart';

class _UserAbout extends StatefulWidget{
  
  const _UserAbout();

  @override
  State<StatefulWidget> createState() => _UserAboutState();
}
class _UserAboutState extends State<_UserAbout> {
  

  
  UserBloc get userBloc => context.read<UserBloc>();
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

            return
              Stack(
                children: [
                    _buildTopMenu(user,isDark),
                    Container(
                      margin: const EdgeInsets.only(top:33),
                      padding : const EdgeInsets.all(5),
                      child:   SingleChildScrollView(
                        padding: EdgeInsets.symmetric(vertical: 19, horizontal: 27),
                        physics: scrollable ? BouncingScrollPhysics() : NeverScrollableScrollPhysics(),
                        child: child,
                      ),
                    )
                ],
              );
          },
          child : Column(
            children : <Widget>[
              _UserInfoTextField(user.description),
              // _buildDescription(user.description),
              SizedBox(height: 30),
              _UserInfoContainer(
                children: [
                  _UserInfoContainerChildren(label: "이름", text: user.name),
                  _UserInfoContainerChildren(label: "연락처", text: user.phoneNumber),
                ],
                isDark: isDark,
              ),
              SizedBox(height: 30),
                _UserInfoContainer(
                      children: [
                        _UserInfoContainerChildren(label: "잔여 횟수", text: user.jobCount.toString()),
                        _UserInfoContainerChildren( type: "row",children: [
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
                  ),
            ]
          )
        );
  
    });
  }

  Widget _buildTopMenu(User user,bool isDark){
    return Column(
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
                        IconButton(
                            onPressed: ()=>{
                              showDialog(
                                context: context,
                                builder : (BuildContext context){
                                  return UserForm(
                                    user : user,
                                    msg: "수정되었습니다.",
                                    onPress : (userProperty) {
                                      userBloc.add(CurrentUserUpdate(userProperty.getUser(user.id)));
                                    }
                                  );
                                }
                              )
                            },
                            icon: Icon(Icons.edit)
                        )
                    // _Label("일정추가",isDark),
                    ],
                  )
                )
              ]
            )
        )
      ]
    );
  }


}