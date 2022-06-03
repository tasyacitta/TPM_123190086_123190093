import 'package:hive_flutter/hive_flutter.dart';
import 'package:prak_b_123190086_123190093/helper/shared_preference.dart';
import 'package:prak_b_123190086_123190093/model/review_model.dart';
import 'package:prak_b_123190086_123190093/model/user_model.dart';

class HiveDatabase{
  Box<UserModel> _localDB = Hive.box<UserModel>("data");
  Box<ReviewModel> _localDBReview = Hive.box<ReviewModel>("data2");

  void addData(UserModel data) {
    _localDB.add(data);
  }

  void addDataReview(ReviewModel data) {
    _localDBReview.add(data);
  }

  int getLength() {
    return _localDB.length;
  }

  int getLengthReviewAll() {
    return _localDBReview.length;
  }

  int getLengthReview(int id_products) {
    int length = 0;
    for(int i = 0; i < _localDBReview.length; i++){
      if (id_products == _localDBReview.getAt(i)!.id_product) {
        length++;
      }
    }
    return length;
  }

  bool checkReview(int id_user, int id_products) {
    bool check = false;
    for(int i = 0; i < _localDBReview.length; i++){
      if (id_user == _localDBReview.getAt(i)!.id_user && id_products == _localDBReview.getAt(i)!.id_product) {
        check = true;
        break;
      }
      else{
        check=false;
      }
    }
    return check;
  }

  List<ReviewModel> getReview(int id_products) {
    List<ReviewModel> list = [];

    for(int i = 0; i < _localDBReview.length; i++){
      if (id_products == _localDBReview.getAt(i)!.id_product) {
        list.add(ReviewModel(
          id: _localDBReview.getAt(i)!.id,
          id_user: _localDBReview.getAt(i)!.id_user,
          id_product: _localDBReview.getAt(i)!.id_product,
          username: _localDBReview.getAt(i)!.username,
          review: _localDBReview.getAt(i)!.review,
          skin_type: _localDBReview.getAt(i)!.skin_type,
          usage_period: _localDBReview.getAt(i)!.usage_period
        ));
      }
    }
    return list;
  }

  bool checkLogin(String username, String password) {
    bool found = false;
    for(int i = 0; i< getLength(); i++){
      if (username == _localDB.getAt(i)!.username && password == _localDB.getAt(i)!.password) {
        SharedPreference().setLogin(username, _localDB.getAt(i)!.id);
        print("Login Success ${_localDB.getAt(i)!.id}",);
        found = true;
        break;
      } else {
        found = false;
      }
    }

    return found;
  }

}