part of '../user.dart';




class _UserGrid extends StatefulWidget{
  const _UserGrid();

  @override
  State<StatefulWidget> createState() => _UserGridState();
}

class _UserGridState extends State<_UserGrid>{

  final GlobalKey<NestedScrollViewState> _scrollKey = GlobalKey();
  @override
  Widget build(BuildContext context){
    return NestedScrollView(
      key : _scrollKey,
      headerSliverBuilder: (_, __) => [
        // MainSliverAppBar(
        //   context: context,
        // ),
      ],
      body : Text('user gird')
    );
  }
}