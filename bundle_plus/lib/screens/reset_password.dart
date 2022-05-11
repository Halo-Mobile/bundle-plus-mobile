import 'package:bundle_plus/screens/home.dart';
import 'package:bundle_plus/screens/login.dart';
import 'package:bundle_plus/screens/registration.dart';
import 'package:bundle_plus/screens/reset_password.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = new TextEditingController();
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final resetPass = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.pinkAccent,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          _auth.sendPasswordResetEmail(email: emailController.text);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => LoginScreen()));
        },
        child: Text(
          "Reset Password",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

    final emailInput = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (input) {
        if (input!.isEmpty) {
          return ("Please enter your email");
        }
        if (!RegExp("^[a-zA-Z0-9=_.-]+@[a-zA-Z0-9=_.-]+.[a-z]")
            .hasMatch(input)) {
          return ("Please return a valid email");
        }
        return null;
      },
      onSaved: (input) {
        emailController.text = input!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.mail,
          color: Colors.pinkAccent,
        ),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "john@gmail.com",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.pinkAccent,
            width: 1.5,
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Password'),
        backgroundColor: Colors.pinkAccent,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(36.0, 18.0, 36.0, 0),
            child: Form(
              key: _formKey,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  emailInput,
                  SizedBox(
                    height: 15,
                  ),
                  resetPass,
                  // const SizedBox(height: 25),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
