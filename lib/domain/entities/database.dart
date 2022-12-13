

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
  });
  
  final String id;
  final String name;
  final String phoneNumber;


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