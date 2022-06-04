import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 1)
class UserModel {
  UserModel({required this.id, required this.username, required this.email, required this.password, required this.fullName});

  @HiveField(0)
  int id;

  @HiveField(1)
  String username;

  @HiveField(2)
  String email;

  @HiveField(3)
  String password;

  @HiveField(4)
  String fullName;

  @override
  String toString() {
    return 'UserModel{id: $id, fullname: $username,password: $password}';
  }
}