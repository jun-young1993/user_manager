import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart' hide AnimatedSlide;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:user_manager/domain/entities/schedule.dart';
import 'package:user_manager/states/schedule/schedule_bloc.dart';
import 'package:user_manager/states/schedule/schedule_event.dart';
import 'package:user_manager/states/schedule/schedule_selector.dart';
import 'package:user_manager/states/schedule/schedule_state.dart';
import 'package:user_manager/states/theme/theme_cubit.dart';
import 'package:user_manager/states/user/user_event.dart';
import 'package:user_manager/states/user/user_selector.dart';
import 'package:user_manager/ui/screens/user_info/state_provider.dart';
import 'package:user_manager/ui/widgets/animated_fade.dart';
import 'package:user_manager/ui/widgets/main_app_bar.dart';
import 'package:user_manager/ui/widgets/auto_slideup_panel.dart';
import 'package:user_manager/ui/widgets/main_tab_view.dart';

import 'package:user_manager/configs/images.dart';
import 'package:user_manager/configs/colors.dart';
import 'package:user_manager/domain/entities/user.dart';
import 'package:user_manager/states/user/user_bloc.dart';
import 'package:user_manager/ui/widgets/user_form.dart';


part 'sections/background_decoration.dart';
part 'sections/user_overall_info.dart';
part 'sections/user_info_card.dart';
part 'sections/user_info_card_about.dart';
part 'sections/user_info_card_schedule.dart';

part 'sections/user_card_widget.dart';
part 'sections/user_info_card_config.dart';
class UserInfo extends StatefulWidget {
  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> with TickerProviderStateMixin {




  late AnimationController _slideController;
  late AnimationController _rotateController;

  @override
  void initState() {
    _slideController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    _rotateController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 5000),
    )..repeat();

    super.initState();
  }

  @override
  void dispose() {
        _slideController.dispose();
    _rotateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return UserInfoStateProvider(
      slideController: _slideController,
      rotateController: _rotateController,
      child: Scaffold(
        body : Stack(
          children: <Widget>[
            _BackgroundDecoration(),
            _UserInfoCard(),
            _UserOverallInfo(),
          ],
        )
      ),
    );
  }
}