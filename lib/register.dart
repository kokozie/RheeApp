import 'package:flutter/material.dart';
import 'package:rhee_app/services/auth.dart';
import 'model/loginuser.dart';


class Register extends StatefulWidget{

  final Function? toggleView;
  const Register({super.key, this.toggleView});

  @override
  State<StatefulWidget> createState() {
    return _Register();
  }
}

class _Register extends State<Register>{
  final AuthService _auth = AuthService();

  bool _obscureText = true;
  final _email = TextEditingController();
  final _password = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    final emailField = TextFormField(
        controller: _email,
        autofocus: false,
        validator: (value) {
          if (value != null) {
            if (value.contains('@') && value.endsWith('.com')) {
              return null;
            }
            return 'Enter a Valid Email Address';
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Email",
            border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));

    final passwordField = TextFormField(
        obscureText: _obscureText,
        controller: _password,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
          if (value.trim().length < 8) {
            return 'Password must be at least 8 characters in length';
          }
          // Return null if the entered password is valid
          return null;
        } ,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Password",
            suffixIcon: IconButton(icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
              onPressed: (){
                setState(() {
                  _obscureText = !_obscureText;
                });
              },),
            border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));

    final txtbutton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.brown,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        onPressed: () {
          widget.toggleView!();
        },
        child: Text(
          'Go to Login',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );


    final registerButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.brown,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            dynamic result = await _auth.registerEmailPassword(LoginUser(email: _email.text,password: _password.text));
            if (result.uid == null) { //null means unsuccessfull authentication
              // ignore: use_build_context_synchronously
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text(result.code),
                    );
                  });
            }
          }
        },
        child: Text(
          'Register',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );



    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Registration'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
            autovalidateMode: AutovalidateMode.always,
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 45.0),
                  emailField,
                  const SizedBox(height: 25.0),
                  passwordField,
                  const SizedBox( height: 35.0),
                  registerButton,
                  const SizedBox(height: 25.0),
                  const SizedBox(height: 25.0),
                  const SizedBox(height: 25.0),
                  txtbutton,
                  const SizedBox(height: 15.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}