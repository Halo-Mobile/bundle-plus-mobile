// import 'dart:html';

import 'package:bundle_plus/screens/home.dart';
import 'package:bundle_plus/screens/login.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:bundle_plus/screens/profilepageedit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/user_model.dart';
import '../model/user_profile.dart';
import 'login.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Widget _buildSingleContainer({String startText = "", String endText = ""}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Container(
        height: 50,
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(30)),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              startText,
              style: TextStyle(fontSize: 18, color: Colors.black45),
            ),
            Text(
              endText,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSingleTextFormField({String name = ""}) {
    return TextFormField(
      decoration: InputDecoration(
          hintText: name,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          )),
    );
  }

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  UserProfile userprofile = UserProfile();
  var _ref;

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

  // @override
  // getPic() async{
  // final pic = FirebaseStorage.instance.ref().child("profiles").child("eleceed.jpg");
  // ref = await pic.getDownloadURL();

  // ref = await FirebaseStorage.instance
  //           .ref("profiles")
  //           .child("avatar.png")
  //           .getDownloadURL();

  // final storageRef = FirebaseStorage.instance.ref();
  // Reference? imageRef = storageRef.child("profiles");
  // final _path = imageRef.child("avatar.png");
  // ref = _path.fullPath;

  // ref = "profiles/${loggedInUser.uid}/profile.jpg";

  //   ref = "profiles/eleceed.jpg";
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    final editButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.pinkAccent,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: 200.0,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ProfilePageEdit()));
        },
        child: const Text(
          "Edit Profile",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

    var children2 = [
      Stack(
        children: [
          Container(
            height: 140,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Image.asset("assets/logo.png", fit: BoxFit.contain),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  maxRadius: 70,
                  backgroundImage: NetworkImage(
                      "https://firebasestorage.googleapis.com/v0/b/bundleplus-91f36.appspot.com/o/profiles%2Favatar.png?alt=media&token=48fce17e-7708-44ab-b1fc-3bd6d389c0d9"),
                ),
              ],
            ),
          ),
          //  Padding(
          //         padding: const EdgeInsets.only(left: 210.0, top: 90),
          //           child: ElevatedButton(
          //           child: Icon(Icons.verified, color: Colors.red,),
          //           onPressed: selectFile,
          //           style: ElevatedButton.styleFrom(
          //             primary: Colors.white,
          //             shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(20),
          //           ),
          //           ),
          //           ),
          //       ),
        ],
      ),
      Container(
        height: 300,
        // color: Colors.blue,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildSingleContainer(
                    // endText: "${loggedInUser.firstName}",
                    endText: "${loggedInUser.firstName}",
                    startText: "First Name",
                  ),
                  _buildSingleContainer(
                    endText: "${loggedInUser.secondName}",
                    startText: "Second Name",
                  ),
                  _buildSingleContainer(
                    endText: "${loggedInUser.email}",
                    startText: "Email",
                  ),
                  _buildSingleContainer(
                    endText: "${userprofile.phoneNum}",
                    startText: "Phone Number",
                  ),
                  _buildSingleContainer(
                    endText: "${userprofile.matricCard}",
                    startText: "Matric Card",
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      editButton,
      // ActionChip(
      //     label: Text("Logout"),
      //     onPressed: () {
      //       logout(context);
      //     }),
    ];
    return Scaffold(
      backgroundColor: Color(0xfff8f8f8),
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const HomeScreen()));
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.black,
            ),
            onPressed: () {
              _showMyDialog();
            },
          )
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: children2,
        ),
      ),
    );
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();

    if (result == null) return;

    setState(() {
      // newDP = result.files.first;
    });
  }

  deleteAccount(BuildContext context) async {
    await user?.delete();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Account'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text(
                    'If you delete your account, you will no longer be able to sign up using the same email.\n'),
                Text('Would you like to proceed to delete your account?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Confirm'),
              onPressed: () {
                print('Confirmed');
                deleteAccount(context);
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
