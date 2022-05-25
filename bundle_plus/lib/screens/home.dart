import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../model/user_model.dart';
import '../model/user_profile.dart';
import 'package:bundle_plus/screens/sell_item.dart';
import '../model/item_model.dart';
import 'login.dart';
import 'package:bundle_plus/screens/profilepage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget _buildFeaturedProduct({String? name, double? price, String? image}) {
    String price2 = price!.toStringAsFixed(2);
    return Card(
      child: Container(
        height: 250,
        width: 150,
        child: Column(
          children: <Widget>[
            Container(
              height: 190,
              width: 160,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/$image"),
                ),
              ),
            ),
            Text(
              "RM $price2",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: Colors.black),
            ),
            Text(
              name!,
              style: TextStyle(
                  // fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryProduct(String icon) {
    int icon2 = int.parse(icon);
    return CircleAvatar(
      maxRadius: 35,
      backgroundColor: Colors.pinkAccent,
      child: IconButton(
          icon: Icon(IconData(icon2, fontFamily: 'MaterialIcons'),
              color: Colors.white),
          onPressed: () {}),
    );
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      endDrawerEnableOpenDragGesture: false,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.pinkAccent,
              ),
              child: Text('Bundle+'),
            ),
            ListTile(
              title: const Text('Sell Item'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SellItems()));
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text(
          "Bundle+",
          style:
              TextStyle(color: Colors.pinkAccent, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.grey[100],
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.pinkAccent,
          ),
          onPressed: () => _key.currentState?.openDrawer(),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.notifications_none, color: Colors.pinkAccent),
              onPressed: () {}),
          IconButton(
              icon:
                  Icon(Icons.account_circle_outlined, color: Colors.pinkAccent),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfilePage()));
              }),
        ],
      ),
      // body: Center(
      //   child: Padding(
      //     padding: EdgeInsets.all(20),
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       children: <Widget>[
      //         SizedBox(
      //           height: 150,
      //           child: Image.asset("assets/logo.png", fit: BoxFit.contain),
      //         ),
      //         Text(
      //           "Welcome Back",
      //           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      //         ),
      //         SizedBox(
      //           height: 10,
      //         ),
      //         Text("${loggedInUser.firstName} ${loggedInUser.secondName}",
      //             style: TextStyle(
      //               color: Colors.black54,
      //               fontWeight: FontWeight.w500,
      //             )),
      //         Text("${loggedInUser.email}",
      //             style: TextStyle(
      //               color: Colors.black54,
      //               fontWeight: FontWeight.w500,
      //             )),
      //         SizedBox(
      //           height: 15,
      //         ),
      //         ActionChip(
      //             label: Text("Logout"),
      //             onPressed: () {
      //               logout(context);
      //             }),
      //             Material(
      //               elevation: 5,
      //               borderRadius: BorderRadius.circular(30),
      //               color: Colors.pinkAccent,
      //               child: MaterialButton(
      //                 padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
      //                 minWidth: 200.0,
      //                 onPressed: () {
      //                   Navigator.push(
      //                       context, MaterialPageRoute(builder: (context) => const ProfilePage()));
      //                 },
      //                 child: const Text(
      //                   "Edit Profile",
      //                   textAlign: TextAlign.center,
      //                   style: TextStyle(
      //                       fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
      //                 ),
      //               ),
      //             )
      //       ],
      //     ),
      //   ),
      // ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            Column(
              children: <Widget>[
                Container(
                  height: 120,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          hintText: "Seach",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                      Container(
                        height: 50,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Featured",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "See all",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            _buildFeaturedProduct(
                                image: "acer.jfif",
                                price: 3500,
                                name: "ACER Predator Helios 300"),
                            _buildFeaturedProduct(
                                image: "ipx.jpg",
                                price: 1500,
                                name: "iPhone X"),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  height: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Categories",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "See all",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      _buildCategoryProduct("0xe3dd"),
                      _buildCategoryProduct("0xe367"),
                      _buildCategoryProduct("0xe25a"),
                      _buildCategoryProduct("0xe5f3"),
                      _buildCategoryProduct("0xe5ef"),
                    ],
                  ),
                ),
                Container(
                  height: 50,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "New Arrival",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "See all",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              _buildFeaturedProduct(
                                  image: "dilo.jpg",
                                  price: 15,
                                  name: "Digital Logic"),
                              _buildFeaturedProduct(
                                  image: "oop.jpg",
                                  price: 20.5,
                                  name: "OOP using JAVA"),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // checkProfileData(){
  //   FirebaseAuth.instance
  //   .authStateChanges()
  //   .listen((User? user) {
  //     if (user != null) {
  //       print(user.uid);
  //     }
  //   });
  // }

  // the logout function
  // Future<void> logout(BuildContext context) async {
  //   await FirebaseAuth.instance.signOut();
  //   Navigator.of(context).pushReplacement(
  //       MaterialPageRoute(builder: (context) => LoginScreen()));
  // }
}
