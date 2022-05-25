import 'package:bundle_plus/screens/home.dart';
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

  //   createNewData() async{
  //   // userprofile.uid = user!.uid;
  //   FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  //   super.initState();
  //   FirebaseFirestore.instance
  //       .collection("users_profile")
  //       .doc(user!.uid)
  //       .get()
  //       .then((value) {
  //     this.userprofile = UserProfile.fromMap(value.data());
  //     setState(() {});
  //   });

  //   if (userprofile.uid == null) {
  //     userprofile.uid == loggedInUser.uid;
  //     userprofile.phoneNum == "";

  //     await firebaseFirestore
  //       .collection("users_profile")
  //       .doc(userprofile.uid)
  //       .update(userprofile.toMap());

  //   }
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
                  backgroundImage: AssetImage("assets/eleceed.jpg"),
                ),
              ],
            ),
          ),
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
                    endText: "0192121",
                    startText: "Phone Number",
                  ),
                  _buildSingleContainer(
                    endText: "A19121",
                    startText: "Matric Card",
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      editButton,
      ActionChip(
          label: Text("Logout"),
          onPressed: () {
            logout(context);
          }),
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
          )),
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

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}
