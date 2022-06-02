import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:prak_b_123190086_123190093/helper/shared_preference.dart';
import 'package:prak_b_123190086_123190093/model/review_model.dart';
import 'package:prak_b_123190086_123190093/model/user_model.dart';
import 'package:prak_b_123190086_123190093/view/homepage.dart';
import 'package:prak_b_123190086_123190093/view/homepage_makeup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initiateLocalDB();
  SharedPreference().getLoginStatus().then((status) {
    runApp(MaterialApp(home: status ? HomePageMakeup() : HomePage()));
  });
  // runApp(const MyApp());
}

void initiateLocalDB() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(ReviewModelAdapter());
  await Hive.openBox<UserModel>("data");
  await Hive.openBox<ReviewModel>("data2");
}