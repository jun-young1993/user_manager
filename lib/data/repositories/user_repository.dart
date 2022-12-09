import 'package:user_manager/domain/entities/user.dart';
import 'package:user_manager/service/user_service.dart';

abstract class UserRepository {
  
  Future<List<User>> get();
  Future<User> find(String id);
  Future<User> create(UserProperty data);
}

class UserDefaultRepository extends UserRepository {
  UserDefaultRepository();

  @override
  Future<List<User>> get() async {
    return UserService().index();
  }


  @override
  Future<User> find(String id) async {
    return UserService().find(id);
  }

  @override
  Future<User> create(UserProperty data) async {
        return UserService().create(data);
  }
}