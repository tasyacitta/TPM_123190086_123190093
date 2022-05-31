import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:prak_b_123190086_123190093/helper/hive_database.dart';
import 'package:prak_b_123190086_123190093/model/user_model.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _fullnameController = TextEditingController();
  TextEditingController _dobController = TextEditingController();

  final HiveDatabase _hive = HiveDatabase();

  DateTime date = DateTime(2022, 11, 11);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register Page"),
        backgroundColor: Color(0xff885566),
      ),
      body: Container(
        color: Color(0xFFFCE4EC),
        padding: EdgeInsets.fromLTRB(50, 50, 50, 20),
        child: Column(
          children: [
            Center(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    'https://c.tenor.com/mVksnz5RgxMAAAAC/beieza-makeup.gif',
                    width: 300,
                    height: 150,
                    fit: BoxFit.cover,
                  )),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _usernameController,
              decoration: const InputDecoration(
                contentPadding: const EdgeInsets.all(20.0),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.pinkAccent, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                fillColor: Colors.white,
                filled: true,
                icon: const Icon(Icons.account_circle, color: Colors.pink),
                labelText: "Username",
                hintText: "Username",
              ),
              validator: (value) =>
                  value!.isEmpty ? 'Username cannot be blank' : null,
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                contentPadding: const EdgeInsets.all(20.0),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.pinkAccent, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                fillColor: Colors.white,
                filled: true,
                icon: const Icon(
                  Icons.email,
                  color: Colors.pink,
                ),
                labelText: 'Email',
                hintText: "yourEmail@mail.com",
              ),
              validator: (value) =>
                  value!.isEmpty ? 'Email cannot be blank' : null,
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _fullnameController,
              decoration: const InputDecoration(
                  contentPadding: const EdgeInsets.all(20.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                    BorderSide(color: Colors.pinkAccent, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                    BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  icon: const Icon(
                    Icons.account_circle,
                    color: Colors.pink,
                  ),
                  labelText: 'Fullname',
                  hintText: 'John Doe'),
              validator: (value) =>
              value!.isEmpty ? 'Name cannot be blank' : null,
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                  contentPadding: const EdgeInsets.all(20.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.pinkAccent, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  icon: const Icon(
                    Icons.vpn_key_outlined,
                    color: Colors.pink,
                  ),
                  labelText: 'Password',
                  hintText: "your password"),
              validator: (value) =>
                  value!.isEmpty ? 'Password cannot be blank' : null,
            ),

            SizedBox(height: 20),
            _buildRegisterButton(),
          ],
        ),
      ),
    );
  }

  Widget _commonSubmitButton({
    required String labelButton,
    required Function(String) submitCallback,
  }) {
    return Container(
      padding: EdgeInsets.fromLTRB(30, 30, 10, 0),
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0),
            ),
            primary: Color(0xFFF8BBD0),
            textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        child: Text(labelButton),
        onPressed: () {
          submitCallback(labelButton);
        },
      ),
    );
  }

  Widget _buildRegisterButton() {
    return _commonSubmitButton(
      labelButton: "Register",
      submitCallback: (value) {
        if (_usernameController.text.isNotEmpty &&
            _passwordController.text.isNotEmpty) {
          _hive.addData(UserModel(
            username: _usernameController.text,
            email: _emailController.text,
            password: _passwordController.text,
            fullName: _fullnameController.text,
          ));
          _usernameController.clear();
          _passwordController.clear();
          setState(() {});

          Navigator.pop(context);
        } else {
          Alert(
            context: context,
            type: AlertType.error,
            title: "Registration Error",
            desc: "Please Try Again",
            buttons: [
              DialogButton(
                color: Color(0xFFF8BBD0),
                child: Text(
                  "OK",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () => Navigator.pop(context),
                width: 120,
              )
            ],
          ).show();
        }
      },
    );
  }
}
