import 'package:bundle_plus/screens/admin/admin_home_view.dart';
import 'package:bundle_plus/screens/home.dart';
import 'package:bundle_plus/screens/registration.dart';
import 'package:bundle_plus/screens/reset_password_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final usernameController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
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
        hintText: "Email",
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

    final passwordInput = TextFormField(
      autofocus: false,
      controller: passwordController,
      validator: (input) {
        RegExp regex = new RegExp(r'^.{8,}$');
        if (input!.isEmpty) {
          return ("Password required");
        }
        if (!regex.hasMatch(input)) {
          return ("Please enter valid password (Min 8 characters)");
        }
      },
      onSaved: (input) {
        passwordController.text = input!;
      },
      obscureText: true,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.vpn_key,
          color: Colors.pinkAccent,
        ),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Password",
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

    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.pinkAccent,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          logIn(emailController.text, passwordController.text);
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => const HomeScreen()));
        },
        child: const Text(
          "Login",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 200,
                      child:
                          Image.asset("assets/logo.png", fit: BoxFit.contain),
                    ),
                    const Text(
                      'Bundle+',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.pinkAccent,
                      ),
                    ),
                    const SizedBox(height: 45),
                    emailInput,
                    const SizedBox(height: 25),
                    passwordInput,
                    Row(
                      children: [
                        Expanded(
                          child: Container(),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ResetPassword()));
                          },
                          child: const Text(
                            "Forgot your password?",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    loginButton,
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text("Don't have an account?"),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RegistrationScreen()));
                          },
                          child: const Text(
                            " SignUp",
                            style: TextStyle(
                              color: Colors.pinkAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // TODO: improve admin checking logic for efficiency
  void logIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((result) {
          FirebaseFirestore.instance
              .collection("users")
              .get()
              .then((QuerySnapshot querySnapshot) {
            querySnapshot.docs.forEach((doc) {
              print(doc["email"]);
              if (email == "admin@bundleplus.com") {
                Fluttertoast.showToast(msg: "Login Sucessful!");
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => AdminHomeScreen()));
              } else {
                print('non admin');
                Fluttertoast.showToast(msg: "Login Sucessful!");
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const HomeScreen()));
              }
            });
          });
        });
      } catch (e) {
        // DONE : Proper Error Handling
        print(e.toString());
        Fluttertoast.showToast(msg: e.toString());
      }

      // .then((uid) => {
      // Fluttertoast.showToast(msg: "Login Sucessful!"),
      // Navigator.of(context).pushReplacement(
      //     MaterialPageRoute(builder: (context) => const HomeScreen()))
      //     })
      //     .catchError((e) {
      // Fluttertoast.showToast(msg: e!.message);
      // });
    }
  }
}
