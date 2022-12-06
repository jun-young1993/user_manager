
import 'package:flutter/material.dart';
import 'package:user_manager/domain/entities/user.dart';
import 'package:user_manager/configs/colors.dart';

class UserCard extends StatelessWidget {
  final User user;
  final void Function()? onPress;

  const UserCard(
    this.user, {
      this.onPress
    }
  );

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder : (context, constrains){
        final itemHeight = constrains.maxHeight;
        final Color userColor = UserColor.defaultColor;
        return Container(
            decoration: BoxDecoration(
            color:  userColor,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: userColor.withOpacity(0.4),
                blurRadius: 15,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child : ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child : InkWell(
              onTap : onPress,
              splashColor: Colors.white10,
              highlightColor: Colors.white10,
              child: Stack(
                children: [
                  _CardUser(user)
                ]
              )
            )
          )
        );
      }
    );
  }
}

class _CardUser extends StatelessWidget {
  final User user;

  const _CardUser(this.user, {Key? key}) : super(key : key);

  @override
  Widget build(BuildContext context) {
     return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 24, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Center(child: Text(user.name),),
            Center(child: Text(user.phoneNumber),),
          ],
        ),
      ),
    );
  }
}