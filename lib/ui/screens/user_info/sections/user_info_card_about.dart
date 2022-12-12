
part of '../user_info.dart';


class _UserAbout extends StatelessWidget {
  final User user;

  const _UserAbout(this.user);

  @override
  Widget build(BuildContext context){
    final slideController = UserInfoStateProvider.of(context).slideController;
    var themeCubit = BlocProvider.of<ThemeCubit>(context, listen: true);
    var isDark = themeCubit.isDark;
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
        ]
      )
    );
  }




}