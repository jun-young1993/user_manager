import 'package:flutter/material.dart';
import 'package:user_manager/ui/widgets/category_background.dart';

part 'sections/user_grid.dart';

class UserScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
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
    return CategoryBackground(
            child: Stack(
              children: [_UserGrid()]
            )
    );
  }

}