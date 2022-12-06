import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_manager/routes.dart';
import 'package:user_manager/configs/images.dart';
import 'package:user_manager/ui/widgets/category_background.dart';
import 'package:user_manager/ui/widgets/main_app_bar.dart';
import 'package:user_manager/ui/widgets/user_card.dart';
import 'package:user_manager/states/user/user_bloc.dart';
import 'package:user_manager/states/user/user_event.dart';
import 'package:user_manager/states/user/user_selector.dart';
import 'package:user_manager/states/user/user_state.dart';
import 'package:user_manager/domain/entities/user.dart';

part 'sections/user_grid.dart';

class UserScreen extends StatefulWidget {
  const UserScreen();

  @override
  State<StatefulWidget> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  // @override
  // void initState() {
  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context){
    return CategoryBackground(
            child: Stack(
              children: [
                _UserGrid()
              ]
            )
    );
  }

}