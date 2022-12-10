part of '../user_info.dart';

class _Label extends Text {
  _Label(String text, bool isDark)
      : super(
          text,
          style: TextStyle(
            color: isDark ? AppColors.whiteGrey.withOpacity(0.6) : AppColors.black.withOpacity(0.6),
            height: 0.8,
          ),
        );
}
class _UserAbout extends StatelessWidget {
  final User user;

  const _UserAbout(this.user);

  @override
  Widget build(BuildContext context){
    final slideController = UserInfoStateProvider.of(context).slideController;
    var themeCubit = BlocProvider.of<ThemeCubit>(context, listen: true);
    var isDark = themeCubit.isDark;
    return AnimatedBuilder(
      animation: slideController, 
      builder: (context, child) {
        final scrollable = slideController.value.floor() == 1;

        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 19, horizontal: 27),
          physics: scrollable ? BouncingScrollPhysics() : NeverScrollableScrollPhysics(),
          child: child,
        );
      },
      child : Column(
        children : <Widget>[
          _buildDescription(user.description),
          SizedBox(height: 30),
          _buildInfoContainer([
            _infoField("이름",user.name,isDark),
            _infoField("연락처",user.phoneNumber,isDark)
          ],context,isDark),
          SizedBox(height: 30),
        ]
      )
    );
  }

  Widget _buildDescription(String description) {
    return Text(
      description,
      style: TextStyle(height: 1.3),
    );
  }


  Widget _infoField(String label, String text, bool isDark){
            // Expanded(
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: children
          //   ),
          // ),
        
    return Expanded(
      child : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children : <Widget>[
          _Label(label, isDark),
          SizedBox(height: 11),
          Text(
            '${text}',
            style: TextStyle(
              height: 0.8,
            ),
          )
        ]
      )
    );
    
  }

  Widget _buildInfoContainer(List<Widget> children, BuildContext context, bool isDark) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            offset: Offset(0, 8),
            blurRadius: 23,
          )
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: children
          
          // Expanded(
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: children
          //   ),
          // ),
        
        
      ),
    );
  }
}