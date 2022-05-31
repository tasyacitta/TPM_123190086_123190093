import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:prak_b_123190086_123190093/helper/hive_database.dart';
import 'package:prak_b_123190086_123190093/helper/shared_preference.dart';
import 'package:prak_b_123190086_123190093/model/user_model.dart';
import 'package:prak_b_123190086_123190093/view/homepage_makeup.dart';
import 'package:prak_b_123190086_123190093/view/register.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void validateAndSave() {
    final FormState? form = _formKey.currentState;
    if(form != null){
      if (form.validate()) {
        print('Form is valid');
      } else {
        print('Form is invalid');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFFCE4EC),
      padding: EdgeInsets.fromLTRB(50,50,50,20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  'https://images.unsplash.com/photo-1596462502278-27bfdc403348?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8bWFrZXVwfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
                    width: 300,
                    height: 200,
                    fit: BoxFit.cover,)
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _usernameController,
              decoration: const InputDecoration(
                contentPadding: const EdgeInsets.all(20.0),
                hintText: "Username",
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
              ),
              validator: (value) => value!.isEmpty ? 'Username cannot be blank':null,
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _passwordController,
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
                hintText: "Password",
              ),
              obscureText: true,
              validator: (value) => value!.isEmpty ? 'Password cannot be blank' : null,
            ),
            _buildLoginButton(),
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
      padding: EdgeInsets.fromLTRB(20,30,20,0),
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

  Widget _buildLoginButton() {
    return _commonSubmitButton(
      labelButton: "Login",
      submitCallback: (value) {
        validateAndSave();
        String currentUsername = _usernameController.value.text;
        String currentPassword = _passwordController.value.text;

        _processLogin(currentUsername, currentPassword);
      },
    );
  }

  void _processLogin(String username, String password) async {
    final HiveDatabase _hive = HiveDatabase();
    bool found = false;

    found = _hive.checkLogin(username, password);

    if(!found) {
      Alert(
        context: context,
        type: AlertType.error,
        title: "Login Error",
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
    else{
        Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomePageMakeup(),
        ),
      );
    }
  }

  Widget _buildRegisterButton() {
    return _commonSubmitButton(
      labelButton: "Register",
      submitCallback: (value) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => RegisterPage(),
          ),
        );
      },
    );
  }
}




































