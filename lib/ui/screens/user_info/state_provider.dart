import 'package:flutter/material.dart';

class UserInfoStateProvider extends InheritedWidget {
  final AnimationController slideController;
  final AnimationController rotateController;
  const UserInfoStateProvider({
    Key? key,
    required this.slideController,
    required this.rotateController,
    required Widget child,
  }) : super(child : child);

  static UserInfoStateProvider of(BuildContext context){
    final result = context.dependOnInheritedWidgetOfExactType<UserInfoStateProvider>();
    return result!;
  }

  @override
  bool updateShouldNotify(covariant UserInfoStateProvider oldWidget) => false;
}