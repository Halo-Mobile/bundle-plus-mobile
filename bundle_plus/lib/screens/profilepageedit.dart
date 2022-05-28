import 'dart:math';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:bundle_plus/screens/profilepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/user_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../model/user_profile.dart';

class ProfilePageEdit extends StatefulWidget {
  const ProfilePageEdit({Key? key}) : super(key: key);

   @override
  _ProfilePageEditState createState() => _ProfilePageEditState();
}

class _ProfilePageEditState extends State<ProfilePageEdit>{
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  UserProfile userprofile = UserProfile();
  PlatformFile? newDP;
  PlatformFile? matricPic;

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

    userprofile.upid = user!.uid;
    FirebaseFirestore.instance
        .collection("users_profile")
        .doc(userprofile.upid)
        .get()
        .then((value) {
      this.userprofile = UserProfile.fromMap(value.data());
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
        phoneNumEditingController.text = value!;
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
        matricCardEditingController.text = value!;
      },
    );
  }
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Color(0xfff8f8f8),
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back, color: Colors.black,), onPressed: (){
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
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Container(
                    height: 140,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          maxRadius: 70,
                          backgroundImage:  NetworkImage("https://firebasestorage.googleapis.com/v0/b/bundleplus-91f36.appspot.com/o/profiles%2Favatar.png?alt=media&token=48fce17e-7708-44ab-b1fc-3bd6d389c0d9"),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 210.0, top: 130),
                    child: ElevatedButton(
                    child: Icon(Icons.edit, color: Colors.black,),
                    onPressed: selectFile,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    ),
                    ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 115.0, top:180),
                  child: ActionChip(
                    label: Text("Verify Account"),
                    onPressed: () {
                      uploadMatric();
                  }),
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
                          name: "${userprofile.phoneNum}",
                        ),
                        _matricCard(
                          name: "${userprofile.matricCard}",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              ),
            ),
          ],
        ),
      ),
        ),
        // height: double.infinity,
        // width: double.infinity,
        // padding: EdgeInsets.symmetric(horizontal: 20.0),
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //     children: [
      //       Stack(
      //         children: [
      //           Container(
      //             height: 140,
      //             width: double.infinity,
      //             child: Column(
      //               mainAxisAlignment: MainAxisAlignment.end,
      //               children: [
      //                 CircleAvatar(
      //                   backgroundColor: Colors.white,
      //                   maxRadius: 70,
      //                   backgroundImage:  NetworkImage("https://firebasestorage.googleapis.com/v0/b/bundleplus-91f36.appspot.com/o/profiles%2Favatar.png?alt=media&token=48fce17e-7708-44ab-b1fc-3bd6d389c0d9"),
      //                 ),
      //               ],
      //             ),
      //           ),
      //           Padding(
      //             padding: const EdgeInsets.only(left: 210.0, top: 90),
      //               child: ElevatedButton(
      //               child: Icon(Icons.edit, color: Colors.black,),
      //               onPressed: selectFile,
      //               style: ElevatedButton.styleFrom(
      //                 primary: Colors.white,
      //                 shape: RoundedRectangleBorder(
      //                 borderRadius: BorderRadius.circular(20),
      //               ),
      //               ),
      //               ),
      //           ),
      //           Padding(
      //             padding: const EdgeInsets.only(left: 115.0, top:140),
      //             child: ActionChip(
      //               label: Text("Verify Account"),
      //               onPressed: () {
      //                 uploadMatric();
      //             }),
      //           ),
      //         ],
      //       ),
      //     Container(
      //         height: 350,
      //         // color: Colors.blue,
      //         width: double.infinity,
      //         child: SingleChildScrollView(
      //           child: Column(
      //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //           children: [
      //             Container(
      //               height: 350,
      //               // color: Colors.red,
      //               child: Column(
      //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //                 children: [
      //                   _firstname(
      //                     name: "${loggedInUser.firstName}",
      //                   ),
      //                   _lastname(
      //                     name: "${loggedInUser.secondName}",
      //                   ),
      //                   _email(
      //                     name: "${loggedInUser.email}",
      //                   ),
      //                   _phonenum(
      //                     name: "${userprofile.phoneNum}",
      //                   ),
      //                   _matricCard(
      //                     name: "${userprofile.matricCard}",
      //                   ),
      //                 ],
      //               ),
      //             ),
      //           ],
      //         ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }

  Future selectFile() async{
    final result = await FilePicker.platform.pickFiles();

    if (result == null) return;

    setState(() {
      newDP = result.files.first;
    });
  }

  Future uploadFile() async{

    if(newDP == null) return;

    try {
  final path = 'profiles/${loggedInUser.uid}/profilepic.${newDP!.extension}';
  final file = File(newDP!.path!);
  
  final ref = FirebaseStorage.instance.ref().child(path);
  await ref.putFile(file);
  } on Exception catch (e) {
    print(e);
  }
  }

  Future uploadMatric() async {
    final result = await FilePicker.platform.pickFiles();

    if (result == null) return;

    setState(() {
      matricPic = result.files.first;
    });
  }

  Future saveMatric() async{
    if(matricPic == null) return;

    try {
    final path = 'userVerifications/${loggedInUser.uid}/${matricPic!.name}';
    final file = File(matricPic!.path!);
    
    final ref = FirebaseStorage.instance.ref().child(path);
    await ref.putFile(file);
    } on Exception catch (e) {
      print(e);
    }
  }

  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sending these values

    uploadFile();
    saveMatric();

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    UserModel userModel = UserModel();
    UserProfile _userprofile = UserProfile();

    // writing all the values
    userModel.email = loggedInUser.email;
    userModel.uid = loggedInUser.uid;
    _userprofile.upid = userprofile.upid;

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

    if (phoneNumEditingController.text != "") {
       _userprofile.phoneNum = phoneNumEditingController.text;
    }else{
      _userprofile.phoneNum = userprofile.phoneNum;
    }

    if (matricCardEditingController.text != "") {
       _userprofile.matricCard = matricCardEditingController.text;
    }else{
      _userprofile.matricCard = userprofile.matricCard;
    }

    await user?.updateEmail("${userModel.email}");

    await firebaseFirestore
        .collection("users")
        .doc(loggedInUser.uid)
        .update(userModel.toMap());

    await firebaseFirestore
        .collection("users_profile")
        .doc(userprofile.upid)
        .update(_userprofile.toMap());
    Fluttertoast.showToast(msg: "Profile edited successfully :) ");

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => const ProfilePage()),
        (route) => false);
  }
}