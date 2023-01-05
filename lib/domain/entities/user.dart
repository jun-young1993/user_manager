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

  User getUser(String id){
    return User(id:id,name:name,phoneNumber: phoneNumber,color: color,description: description,disable: disable,jobCount: jobCount);
  }

}

class User{

  const User({
    required this.id,
    required this.name,
    required this.phoneNumber,
    this.color = "0xFFA8A878",
    this.description = "no description",
    this.disable = false,
    this.jobCount = 0,
    this.checked = false
  });

  final String id;
  final String name;
  final String phoneNumber;
  final String color;
  final String description;
  final bool disable;
  final int jobCount;
  final bool checked;

  User plusJobCount(){
    return User(id:id,name:name,phoneNumber: phoneNumber,color: color,description: description,disable: disable,jobCount: jobCount+1, checked: checked);
  }
  User minusJobCount(){
    return User(id:id,name:name,phoneNumber: phoneNumber,color: color,description: description,disable: disable,jobCount: jobCount-1, checked: checked);
  }

  User setCheck(bool checked){
    return User(id:id,name:name,phoneNumber: phoneNumber,color: color,description: description,disable: disable,jobCount: jobCount, checked: checked);
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