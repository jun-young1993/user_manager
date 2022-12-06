part of '../user_info.dart';

class _BoxDecoration extends StatelessWidget {
  static const Size size = Size.square(144);

  const _BoxDecoration();

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: pi * 5 / 12,
      alignment: Alignment.center,
      child: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            begin: Alignment(-0.2, -0.2),
            end: Alignment(1.5, -0.3),
            colors: [
              Colors.white.withOpacity(0.3),
              Colors.white.withOpacity(0),
            ],
          ),
        ),
      ),
    );
  }
}

class _DottedDecoration extends StatelessWidget {
  static const Size size = Size(57, 31);

  final Animation<double> animation;

  const _DottedDecoration({required this.animation});

  @override
  Widget build(BuildContext context) {
    return AnimatedFade(
      animation: animation,
      child: Image(
        image: AppImages.dotted,
        width: size.width,
        height: size.height,
        color: Colors.white30,
      ),
    );
  }

  // const _DottedDecoration({
  //   required Animation<double> animation,
  // }) : super(
  //         animation: animation,
  //         child: const Image(
  //           image: AppImages.dotted,
  //           width: size.width,
  //           height: size.height,
  //           color: Colors.white30,
  //         ),
  //       );
}

class _BackgroundDecoration extends StatefulWidget {
  const _BackgroundDecoration();

  @override
  State<_BackgroundDecoration> createState() => _BackgroundDecorationState();
}

class _BackgroundDecorationState extends State<_BackgroundDecoration> {
  // Animation<double> get slideController => UserInfoStateProvider.of(context).slideController;
  // Animation<double> get rotateController => UserInfoStateProvider.of(context).rotateController;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildBackground()
         
        // _buildBackground(),
        // _buildBoxDecoration(),
        // _buildDottedDecoration(),
        // _buildAppBarPokeballDecoration(),
      ],
    );
  }

  Widget _buildBackground() {
    return CurrentUserSelector((pokemon) {
      return AnimatedContainer(
        duration: Duration(milliseconds: 300),
        constraints: BoxConstraints.expand(),
        color: UserColor.defaultColor,
      );
    });
  }

}
