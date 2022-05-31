import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 1)
class UserModel {
  UserModel({required this.username, required this.email, required this.password, required this.fullName});

  @HiveField(0)
  String username;

  @HiveField(1)
  String email;

  @HiveField(2)
  String password;


  @HiveField(3)
  String fullName;

  @override
  String toString() {
    return 'UserModel{fullname: $username,password: $password}';
  }
}