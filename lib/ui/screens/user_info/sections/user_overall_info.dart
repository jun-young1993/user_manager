part of '../user_info.dart';

class _UserOverallInfo extends StatefulWidget {
  const _UserOverallInfo();

  @override
  _UserOverallInfoState createState() => _UserOverallInfoState();
}


class _UserOverallInfoState extends State<_UserOverallInfo> with SingleTickerProviderStateMixin {
  final GlobalKey _currentTextKey = GlobalKey();
  final GlobalKey _targetTextKey = GlobalKey();

  

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildAppBar(),
        // SizedBox(height: 9),
      ],
    );
  }

  AppBar _buildAppBar() {
    return MainAppBar(
      title : CurrentUserSelector((user) {
        
        return Text(user.name,
            // key: _targetTextKey,
            // style: TextStyle(
            //   color: Color.fromARGB(0, 46, 17, 173),
            // // // fontWeight: FontWeight.w900,
            // // // fontSize: 22,
            // ),
        );
      }),
      // rightIcon: Icons.favorite_border
    );
   
  }

}