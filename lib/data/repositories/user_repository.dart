import 'package:user_manager/domain/entities/user.dart';
import 'package:user_manager/service/user_service.dart';

abstract class UserRepository {
  
  Future<List<User>> getAllUsers();
  Future<List> getUsers();
  Future<User> getUser(String id);
}

class UserDefaultRepository extends UserRepository {
  UserDefaultRepository();

  @override
  Future<List<User>> getAllUsers() async {
    return UserService().index();
  }

  @override
  Future<List> getUsers() async {
    return ["test"];
  }

  @override
  Future<User> getUser(String id) async {
    return UserService().find(id);
  }
}