part of 'package:user_manager/ui/screens/user/user.dart';

class _FabMenu extends StatefulWidget {
  const _FabMenu();

  @override
  State<_FabMenu> createState() => _FabMenuState();
}


class _FabMenuState extends State<_FabMenu> with SingleTickerProviderStateMixin {
    late AnimationController _fabController;
    late Animation<double> _fabAnimation;

    bool _isFabMenuVisible = false;
    UserBloc get userBloc => context.read<UserBloc>();
    @override
    void initState() {
      _fabController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 260),
      );
      _fabAnimation = _fabController.curvedTweenAnimation(
        begin: 0.0,
        end: 1.0,
      );

      super.initState();
    }

    @override
    void dispose() {
      _fabController.dispose();

      super.dispose();
    }

    void _toggleFabMenu() {
      _isFabMenuVisible = !_isFabMenuVisible;

      if (_isFabMenuVisible) {
        _fabController.forward();
      } else {
        _fabController.reverse();
      }
    }

    void onPress([Function? callback]) {
      _toggleFabMenu();

      callback?.call();
    }

    @override
    Widget build(BuildContext context){
      final safeAreaBottom = MediaQuery.of(context).padding.bottom;

      return AnimatedOverlay(
        animation: _fabAnimation,
        color: Colors.black,
        onPress: _toggleFabMenu,
        child: Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.only(right: 26, bottom: 26 + safeAreaBottom),
              child: ExpandedAnimationFab(
                animation: _fabAnimation,
                onPress: _toggleFabMenu,  
                items : [
                  FabItemData(
                    '회원 추가',
                    Icons.person_add_sharp,
                    onPress: () => onPress((){

                      showUserDialog(context);
                    }),
                  ),

                ]
              )
        )
      );
    }



    void showUserDialog(BuildContext context){
      showDialog(
        context : context,
        builder : (BuildContext context) {
          return UserForm(
            msg : "추가되었습니다.",
            onPress: (userProperty) {
              userBloc.add(UserCreated(userProperty));
            },
          );
        }

      );
       
       

    }
}