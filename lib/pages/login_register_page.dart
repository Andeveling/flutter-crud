import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String errorMessage = '';
  bool isLogin = true;
  bool isEmailCorrect = true;
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
          email: _controllerEmail.text, password: _controllerPassword.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message!;
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
          email: _controllerEmail.text, password: _controllerPassword.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message!;
      });
    }
  }

  Widget _title() => Text(isLogin ? 'Login' : 'Register');
  Widget _textHeader() => Text(
        isLogin ? 'Login Now' : 'Register Now',
        style: GoogleFonts.poppins(
          textStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 40,
          ),
        ),
      );
  Widget _entryField(
      String title, TextEditingController controller, bool passwordConf) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: title),
      obscureText: passwordConf,
      enableSuggestions: passwordConf,
      autocorrect: passwordConf,
    );
  }

  Widget _submitButton() {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            backgroundColor: isEmailCorrect == false ? Colors.red : Colors.blue,
            padding: const EdgeInsets.symmetric(horizontal: 131, vertical: 20)),
        onPressed: isLogin
            ? signInWithEmailAndPassword
            : createUserWithEmailAndPassword,
        child: Text(isLogin ? 'Login' : 'Register'));
  }

  Widget _loginOrRegisterButton() {
    return TextButton(
        onPressed: () {
          setState(() {
            isLogin = !isLogin;
          });
        },
        child: Text(isLogin ? 'Register Instead' : 'Login Instead'));
  }

  Widget _errorMessage() =>
      Text(errorMessage == '' ? '' : 'Humm ? $errorMessage');

  Widget _space() => const SizedBox(
        height: 20,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _title(),
      ),
      body: Container(
          height: double.infinity,
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            width: 400,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _textHeader(),
                _space(),
                _entryField('Email', _controllerEmail, false),
                _space(),
                _entryField('Password', _controllerPassword, true),
                _space(),
                _errorMessage(),
                _space(),
                _submitButton(),
                _space(),
                _loginOrRegisterButton(),
              ],
            ),
          )),
    );
  }
}
