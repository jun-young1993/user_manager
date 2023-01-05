part of '../user.dart';




class _UserGrid extends StatefulWidget{
  const _UserGrid();

  @override
  State<StatefulWidget> createState() => _UserGridState();
}

class _UserGridState extends State<_UserGrid>{

  final GlobalKey<NestedScrollViewState> _scrollKey = GlobalKey();

  UserBloc get userBloc => context.read<UserBloc>();

  @override
  void initState() {
    super.initState();

    userBloc.add(UserLoadStarted());
  }

  void _onUserPress(User user) {
    print("onUserPress userId ${user.id}");
    userBloc.add(UserSelectChanged(id: user.id));
    print("onUserPress User ${user}");
    AppNavigator.push(Routes.userInfo, user);
  }
  
  void _onChecked(User user, bool checked) {
    print('checked ${checked}');
    userBloc.add(UserCheckChanged(id:user.id, checked: checked));
  }

  @override
  Widget build(BuildContext context){
    return NestedScrollView(
      key : _scrollKey,
      headerSliverBuilder: (_, __) => [
        MainSliverAppBar(
          title : CategoryNames.user,
          context: context,
        ),
      ],
      body : UserStateStatusSelector((status) {
        print("user grid body status $status");



        
        switch(status){
          case UserStateStatus.loading:
            return _buildLoading();
          case UserStateStatus.loadSuccess:
          case UserStateStatus.loadMoreSuccess:
          case UserStateStatus.loadingMore:
            return _buildGrid();
          default:
            return Container();
        }
      })
    );
  }

  Widget _buildLoading() {
    return Center(
      child : Image(image: AppImages.loader)
    );
  }

  Widget _buildGrid() {
    return CustomScrollView(
      slivers : [
        SliverPadding(
          padding: EdgeInsets.all(28),
          sliver: NumberOfUsersSelector((numberOfUsers) {
            
            return SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              delegate: SliverChildBuilderDelegate(
                (_, index) {
                  
                  return UserSelector(index, (user, _) {
                    return UserCard(
                      user,
                      onPress : () => _onUserPress(user),
                      onChecked :  _onChecked
                    );
                  });
                },
                childCount : numberOfUsers
              )
            );
          })
        )
      ]
    );
  }
}