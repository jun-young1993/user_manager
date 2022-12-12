// import 'package:flutter/material.dart';
// import 'package:user_manager/configs/colors.dart';
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

class _UserInfoTextField extends StatelessWidget {
  final String text;
  const _UserInfoTextField(String this.text);

  @override
  Widget build(BuildContext context){
      return Text(
      this.text,
      style: TextStyle(height: 1.3),
    );
  }
}

class _UserInfoContainerChildren {
  const _UserInfoContainerChildren({
    this.label = "",
    this.text = "",
    this.children
  });
  final String? label ;
  final String? text;
  final List<Widget>? children;
}
class _UserInfoContainer extends StatelessWidget {
  final List<_UserInfoContainerChildren> children;
  final bool isDark;

  const _UserInfoContainer({
    required this.children,
    required this.isDark
  });
  Widget build(BuildContext context){
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
          children: this.children.map((row) => 
            Expanded(
              child : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children : <Widget>[
                  _Label(row.label.toString(), this.isDark),
                    SizedBox(height: 11),
                  row.children == null
                  ? Text(
                      '${row.text}',
                      style: TextStyle(
                        height: 0.8,
                        ),
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.max,
                      children : [
                      ...row.children!.map((child) => Expanded(child: child)).toList()]
                    )
                ]
              )
            )
          ).toList()
            
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