abstract class UserRepository {
  

  Future<List> getUsers();
}

class UserDefaultRepository extends UserRepository {
  UserDefaultRepository();

  @override
  Future<List> getUsers() async {
    return ["test"];
  }
}