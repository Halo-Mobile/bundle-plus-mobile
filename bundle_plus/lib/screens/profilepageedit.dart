import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:bundle_plus/screens/profilepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/user_model.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProfilePageEdit extends StatefulWidget {
  const ProfilePageEdit({Key? key}) : super(key: key);

   @override
  _ProfilePageEditState createState() => _ProfilePageEditState();
}

class _ProfilePageEditState extends State<ProfilePageEdit>{
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  final firstNameEditingController = new TextEditingController();
  final secondNameEditingController = new TextEditingController();
  final emailEditingController = new TextEditingController();
  final phoneNumEditingController = new TextEditingController();
  final matricCardEditingController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  Widget _buildSingleContainer({String startText="", String endText=""}){
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30)
        ),
        child: Container(
          height: 50,
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          decoration: BoxDecoration(
            color:  Colors.white,
            borderRadius: BorderRadius.circular(30)
          ),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                startText,
                style: TextStyle(fontSize: 18,color: Colors.black45), 
                ),
                Text(
                endText,
                style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold), 
                ),
            ],
          ),
        ),
      );
  }
  Widget _firstname({String name=""}){
    return TextFormField(
      keyboardType: TextInputType.name,
      controller: firstNameEditingController,
      decoration: InputDecoration(
        hintText: name,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        )
      ),
      onSaved: (value){
        firstNameEditingController.text = value!;
      },
    );
  }

  Widget _lastname({String name=""}){
    return TextFormField(
      keyboardType: TextInputType.name,
      controller: secondNameEditingController,
      decoration: InputDecoration(
        hintText: name,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        )
      ),
      onSaved: (value){
        secondNameEditingController.text = value!;
      },
    );
  }

  Widget _email({String name=""}){
    return TextFormField(
      keyboardType: TextInputType.name,
      controller: emailEditingController,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please enter your email");
        }
        if (!RegExp("^[a-zA-Z0-9=_.-]+@[a-zA-Z0-9=_.-]+.[a-z]")
            .hasMatch(value)) {
          return ("Please return a valid email");
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: name,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        )
      ),
      onSaved: (value){
        emailEditingController.text = value!;
      },
    );
  }

  Widget _phonenum({String name=""}){
    return TextFormField(
      keyboardType: TextInputType.name,
      controller: phoneNumEditingController,
      decoration: InputDecoration(
        hintText: name,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        )
      ),
      onSaved: (value){

      },
    );
  }

  Widget _matricCard({String name=""}){
    return TextFormField(
      keyboardType: TextInputType.name,
      controller: matricCardEditingController,
      decoration: InputDecoration(
        hintText: name,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        )
      ),
      onSaved: (value){

      },
    );
  }
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xfff8f8f8),
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.close, color: Colors.black,), onPressed: (){
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const ProfilePage()));
        },),
        backgroundColor: Colors.white,
        actions: [
          IconButton(icon: Icon(Icons.check, color: Colors.black,), onPressed: (){
            postDetailsToFirestore();
          },)
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Stack(
              children: [
                Container(
                  height: 140,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        maxRadius: 70,
                        backgroundImage: AssetImage("assets/eleceed.jpg"),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 220.0, top: 90),
                  child: Card(
                    // shape: RoundedRectangleBorder(
                    //   borderRadius: BorderRadius.circular(20),
                    // ),
                    child: ElevatedButton(
                      // backgroundColor: Colors.transparent,
                    child: Icon(Icons.edit, color: Colors.black,),
                    onPressed: uploadFile,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    ),
                    ),
                  ),
                ),
              ],
            ),
          Container(
              height: 350,
              // color: Colors.blue,
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 350,
                    // color: Colors.red,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _firstname(
                          name: "${loggedInUser.firstName}",
                        ),
                        _lastname(
                          name: "${loggedInUser.secondName}",
                        ),
                        _email(
                          name: "${loggedInUser.email}",
                        ),
                        _phonenum(
                          name: "01921212",
                        ),
                        _matricCard(
                          name: "A19121",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              ),
              // child: Column(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     Container(
              //       height: 350,
              //       color: Colors.red,
              //       child: Column(
              //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //         children: [
              //           _firstname(
              //             name: "${loggedInUser.firstName}",
              //           ),
              //           _lastname(
              //             name: "${loggedInUser.secondName}",
              //           ),
              //           _email(
              //             name: "${loggedInUser.email}",
              //           ),
              //           _phonenum(
              //             name: "01921212",
              //           ),
              //           _matricCard(
              //             name: "A19121",
              //           ),
              //         ],
              //       ),
              //     ),
              //   ],
              // ),
            ),
          ],
        ),
      ),
    );
  }

  Future uploadFile() async{
    final result = await FilePicker.platform.pickFiles();
  }

  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sending these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.email = loggedInUser.email;
    userModel.uid = loggedInUser.uid;

    if (firstNameEditingController.text != "") {
       userModel.firstName = firstNameEditingController.text;
    }else{
      userModel.firstName = loggedInUser.firstName;
    }
    
    if (secondNameEditingController.text != "") {
       userModel.secondName = secondNameEditingController.text;
    }else{
      userModel.secondName = loggedInUser.secondName;
    }

    if (emailEditingController.text != "") {
       userModel.email = emailEditingController.text;
    }else{
      userModel.email = loggedInUser.email;
    }

    await user?.updateEmail("${userModel.email}");

    await firebaseFirestore
        .collection("users")
        .doc(loggedInUser.uid)
        .update(userModel.toMap());
    Fluttertoast.showToast(msg: "Profile edited successfully :) ");

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => const ProfilePage()),
        (route) => false);
  }
}