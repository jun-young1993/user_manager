part of '../user_info.dart';

class _UserInfoCard extends StatefulWidget {
  static const double minCardHeightFraction = 0.54;

  const _UserInfoCard();

  @override
  State<_UserInfoCard> createState() => _UserInfoCardState();
}

class _UserInfoCardState extends State<_UserInfoCard> {
   AnimationController get slideController => UserInfoStateProvider.of(context).slideController;

  @override
  Widget build(BuildContext context){
    final screenHeight = MediaQuery.of(context).size.height;
    final safeArea = MediaQuery.of(context).padding;
    final appBarHeight = AppBar().preferredSize.height;

    final cardMinHeight = screenHeight * _UserInfoCard.minCardHeightFraction;
    final cardMaxHeight = screenHeight - appBarHeight - safeArea.top;
    return AutoSlideUpPanel(
      minHeight: cardMinHeight,
      maxHeight: cardMaxHeight,
      onPanelSlide: (position) => slideController.value = position,
      child: CurrentUserSelector((user) {
        print("user_info_card tab view ${user}");
        return MainTabView(
          paddingAnimation: slideController,
          tabs : [
            MainTabData(
              label : "회원 정보",
              child : _UserAbout(user)
            ),
            MainTabData(
                label : "일정관리",
                child : _UserAbout(user)
            )
          ]
        );
      }),
    );
  }
}