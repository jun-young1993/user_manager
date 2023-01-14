

class DatabaseProperty {
  const DatabaseProperty({
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
  // final String color = DatabaseColor.defaultColor.toString();
}

class Database{
  
  const Database({
    required this.id,
    required this.name,
    required this.phoneNumber,
    this.users,
    this.schedule
  });
  
  final String id;
  final String name;
  final String phoneNumber;
  final String? users;
  final String? schedule;


  factory Database.fromJson(Database database) {

    return Database(
      id : database.id,
      name: database.name,
      phoneNumber: database.phoneNumber,
      schedule: database.schedule,
      users: database.users
    );
  }

  bool isEqual(Database database) {
    return id == database.id;
  }

  static List<Database> fromJsonList(List list) {

    return list.map((item) => Database.fromJson(item)).toList();
  }

  @override
  String toString() => name;
  // const Database({
  //   required this.id,
  //   required this.name,
  //   required this.phoneNumber
  // })
  // final String id;
  // final String name;
  // final String phoneNumber;
}

class DatabaseId {
  const DatabaseId({
    required this.schemaId,
    required this.userId,
    required this.scheduleId
  });
  
  final String schemaId;
  final String userId;
  final String scheduleId;

  DatabaseId.fromJson(Map<String, dynamic> json)
      : schemaId = json['schemaId'],
        userId = json['userId'],
        scheduleId = json['scheduleId'];

  Map<String, dynamic> toJson() =>
    {
      'schemaId': schemaId,
      'userId': userId,
      'scheduleId' : scheduleId
    };
}