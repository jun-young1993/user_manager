import 'package:user_manager/configs/colors.dart';

class UserProperty {
  const UserProperty({
    required this.name,
    required this.phoneNumber,
    this.color = "0xFFA8A878",
    this.description = "no description",
    this.disable = false,
    this.jobCount = 0
  });

  final String name;
  final String phoneNumber;
  final String color;
  final String description;
  final bool disable;
  final int jobCount;


}

class User{
  
  const User({
    required this.id,
    required this.name,
    required this.phoneNumber,
    this.color = "0xFFA8A878",
    this.description = "no description",
    this.disable = false,
    this.jobCount = 0
  });
  
  final String id;
  final String name;
  final String phoneNumber;
  final String color;
  final String description;
  final bool disable;
  final int jobCount;

  User plusJobCount(){
    return User(id:id,name:name,phoneNumber: phoneNumber,color: color,description: description,disable: disable,jobCount: jobCount+1);
  }
  User minusJobCount(){
    return User(id:id,name:name,phoneNumber: phoneNumber,color: color,description: description,disable: disable,jobCount: jobCount-1);
  }



  // const User({
  //   required this.id,
  //   required this.name,
  //   required this.phoneNumber
  // })
  // final String id;
  // final String name;
  // final String phoneNumber;
}