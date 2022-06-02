import 'package:hive/hive.dart';

part 'review_model.g.dart';

@HiveType(typeId: 2)
class ReviewModel {
  ReviewModel({required this.id, required this.id_user,required this.id_product, required this.username, required this.review, required this.usage_period, required this.skin_type});

  @HiveField(0)
  int id;

  @HiveField(1)
  int id_user;

  @HiveField(2)
  int id_product;

  @HiveField(3)
  String username;

  @HiveField(4)
  String review;

  @HiveField(5)
  String usage_period;

  @HiveField(6)
  String skin_type;

  @override
  String toString() {
    return 'ReviewModel{id: $id, id_user: $id_user, id_product: $id_product, username: $username, review: $review, usage_period: $usage_period, skin_type: $skin_type}';
  }
}