import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:prak_b_123190086_123190093/helper/hive_database.dart';
import 'package:prak_b_123190086_123190093/model/user_model.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final HiveDatabase _hive = HiveDatabase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register Page"),
        backgroundColor: Color(0xff885566),
      ),
      body: Container(
        color: Color(0xFFFCE4EC),
        padding: EdgeInsets.fromLTRB(200,20,100,20),
        child: Column(
          children: [
            Center(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                  'https://c.tenor.com/mVksnz5RgxMAAAAC/beieza-makeup.gif',
                     width: 700,
                    height: 300,
                    fit: BoxFit.cover,)
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _usernameController,
              decoration: const InputDecoration(
                contentPadding: const EdgeInsets.all( 20.0),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.pinkAccent, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                fillColor: Colors.white,
                filled: true,
                icon: const Icon(
                    Icons.account_circle,
                    color: Colors.pink),
                hintText: "Username",
              ),
              validator: (String? value) {
                if (value!.trim().isEmpty) {
                  return 'Username is required';
                }
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                contentPadding: const EdgeInsets.all( 20.0),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.pinkAccent, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                fillColor: Colors.white,
                filled: true,
                icon: const Icon(
                  Icons.vpn_key_outlined,
                  color: Colors.pink,
                ),
                labelText: 'Password',
              ),
              validator: (String? value) {
                if (value!.trim().isEmpty) {
                  return 'Password is required';
                }
              },
            ),
            _buildRegisterButton(),
          ],
        ),
      ),
    );
  }

  Widget _commonSubmitButton({
    required String labelButton,
    required Function(String) submitCallback,
  }){
    return Container(
      padding: EdgeInsets.fromLTRB(200,30,200,0),
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0),),
            primary: Color(0xFFF8BBD0),
            textStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold)),
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
        if (_usernameController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
          _hive.addData(
              UserModel(
                  username: _usernameController.text,
                  password: _passwordController.text
              )
          );
          _usernameController.clear();
          _passwordController.clear();
          setState(() {});

          Navigator.pop(context);
        }
      },
    );
  }
}