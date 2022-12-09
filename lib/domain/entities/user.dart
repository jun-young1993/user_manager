import 'package:user_manager/configs/colors.dart';

class UserProperty {
  const UserProperty({
    required this.name,
    required this.phoneNumber,
    // this.color = "0xFFA8A878",
    // this.description = "",
    // this.disable = false
  });

  final String name;
  final String phoneNumber;
  // final String? color;
  // final String description;
  // final bool disable;
  // final String color = UserColor.defaultColor.toString();
}

class User{
  
  const User({
    required this.id,
    required this.name,
    required this.phoneNumber,
  });
  
  final String id;
  final String name;
  final String phoneNumber;


  // const User({
  //   required this.id,
  //   required this.name,
  //   required this.phoneNumber
  // })
  // final String id;
  // final String name;
  // final String phoneNumber;
}