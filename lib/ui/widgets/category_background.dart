import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_manager/configs/colors.dart';
import 'package:user_manager/configs/images.dart';

class CategoryBackground extends StatelessWidget {
  static const double _pokeballWidthFraction = 0.664;

  final Widget child;
  final Widget? floatingActionButton;

  const CategoryBackground({
    Key? key,
    required this.child,
    this.floatingActionButton,
  }) : super(key: key);


  @override
  Widget build(BuildContext context){
    final safeAreaTop = MediaQuery.of(context).padding.top;
    final pokeballSize = MediaQuery.of(context).size.width * _pokeballWidthFraction;
    final appBarHeight = AppBar().preferredSize.height;
    // final iconButtonPadding = mainAppbarPadding;
    final iconButtonPadding = 28;
    final iconSize = IconTheme.of(context).size ?? 0;

    final pokeballTopMargin = -(pokeballSize / 2 - safeAreaTop - appBarHeight / 2);
    final pokeballRightMargin = -(pokeballSize / 2 - iconButtonPadding - iconSize / 2);

    // var themeCubit = BlocProvider.of<ThemeCubit>(context, listen: true);
    var isDark = false;
    return Scaffold(
      body : Stack(
        fit: StackFit.expand, 
         children: [
          Positioned(
            top: pokeballTopMargin,
            right: pokeballRightMargin,
            child: Image(
              image: AppImages.pokeball,
              width: pokeballSize,
              height: pokeballSize,
              color: !isDark ? AppColors.whiteGrey : Colors.black.withOpacity(0.05),
            ),
          ),
          child,
        ],
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}