import 'dart:ffi';

import 'package:bundle_plus/screens/detailscreen.dart';
import 'package:bundle_plus/screens/listproduct.dart';
import 'package:bundle_plus/widgets/singleproduct.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../model/user_model.dart';
import '../model/user_profile.dart';
import 'package:bundle_plus/screens/sell_item.dart';
import '../model/item_model.dart';
import 'login.dart';
import 'package:bundle_plus/screens/profilepage.dart';
import 'package:carousel_pro/carousel_pro.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

ItemModel featured1 = new ItemModel();
ItemModel featured2 = new ItemModel();
ItemModel new1 = new ItemModel();
ItemModel new2 = new ItemModel();
var mySnapShot;

class _HomeScreenState extends State<HomeScreen> {
  Widget _buildCategoryProduct(String icon) {
    int icon2 = int.parse(icon);
    return CircleAvatar(
      maxRadius: 40,
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

  bool homeColor = true;
  bool sellColor = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      endDrawerEnableOpenDragGesture: false,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            // const DrawerHeader(
            //   decoration: BoxDecoration(
            //     color: Colors.pinkAccent,
            //   ),
            //   child: Text('Bundle+'),
            // ),
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://firebasestorage.googleapis.com/v0/b/bundleplus-91f36.appspot.com/o/profiles%2Favatar.png?alt=media&token=48fce17e-7708-44ab-b1fc-3bd6d389c0d9"),
              ),
              accountName:
                  Text("${loggedInUser.firstName} ${loggedInUser.secondName}"),
              accountEmail: Text("${loggedInUser.email}"),
            ),
            ListTile(
              selected: homeColor,
              enabled: true,
              leading: Icon(Icons.home),
              title: Text(
                'Home',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                setState(() {
                  homeColor = true;
                  sellColor = false;
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                );
              },
            ),
            ListTile(
              selected: sellColor,
              leading: Icon(Icons.sell),
              title: Text(
                'Sell Item',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                setState(() {
                  homeColor = false;
                  sellColor = true;
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SellItems(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.logout_outlined),
              title: Text(
                'Log Out',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                logout(context);
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
              icon: Icon(Icons.search, color: Colors.pinkAccent),
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
      body: FutureBuilder(
        future: FirebaseFirestore.instance.collection("items").get(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          mySnapShot = snapshot;
          featured1 = ItemModel(
            iid: snapshot.data.docs[2]["iid"],
            image: snapshot.data.docs[2]["image"],
            name: snapshot.data.docs[2]["name"],
            price: snapshot.data.docs[2]["price"],
            description: snapshot.data.docs[2]["description"],
            category: snapshot.data.docs[2]["category"],
            condition: snapshot.data.docs[2]["condition"],
            used: snapshot.data.docs[2]["used"],
          );
          featured2 = ItemModel(
              iid: snapshot.data.docs[3]["iid"],
              image: snapshot.data.docs[3]["image"],
              name: snapshot.data.docs[3]["name"],
              price: snapshot.data.docs[3]["price"],
              description: snapshot.data.docs[3]["description"],
              category: snapshot.data.docs[3]["category"],
              condition: snapshot.data.docs[3]["condition"],
              used: snapshot.data.docs[3]["used"]);
          // Query query = snapshot.child("childname").orderByKey().limitToLast(1);
          new1 = ItemModel(
              iid: snapshot.data.docs[0]["iid"],
              image: snapshot.data.docs[0]["image"],
              name: snapshot.data.docs[0]["name"],
              price: snapshot.data.docs[0]["price"],
              description: snapshot.data.docs[0]["description"],
              category: snapshot.data.docs[0]["category"],
              condition: snapshot.data.docs[0]["condition"],
              used: snapshot.data.docs[0]["used"]);
          new2 = ItemModel(
              iid: snapshot.data.docs[1]["iid"],
              image: snapshot.data.docs[1]["image"],
              name: snapshot.data.docs[1]["name"],
              price: snapshot.data.docs[1]["price"],
              description: snapshot.data.docs[1]["description"],
              category: snapshot.data.docs[1]["category"],
              condition: snapshot.data.docs[1]["condition"],
              used: snapshot.data.docs[1]["used"]);
          return Container(
            height: double.infinity,
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: ListView(
              children: [
                Column(
                  children: <Widget>[
                    Container(
                      // height: 120,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    height: 240,
                                    child: Carousel(
                                      autoplay: true,
                                      showIndicator: false,
                                      images: [
                                        AssetImage('assets/acer.jfif'),
                                        AssetImage('assets/ipx.jpg'),
                                        AssetImage('assets/windbreaker.jpg'),
                                        AssetImage('assets/sidemirror.jpg'),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 50,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          "Categories",
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 60,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        _buildCategoryProduct("0xe3dd"),
                                        _buildCategoryProduct("0xe367"),
                                        _buildCategoryProduct("0xe25a"),
                                        _buildCategoryProduct("0xf02a4"),
                                        _buildCategoryProduct("0xe5f3"),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        "Featured",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                              builder: (ctx) => ListProduct(
                                                name: "All Products",
                                                snapShot: mySnapShot,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          "View all",
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                              builder: (ctx) => DetailScreen(
                                                image:
                                                    "assets/${featured1.image}",
                                                price: featured1.price,
                                                name: featured1.name,
                                                description:
                                                    featured1.description,
                                                condition: featured1.condition,
                                                used: featured1.used,
                                              ),
                                            ),
                                          );
                                        },
                                        child: SingleProduct(
                                            image: featured1.image,
                                            price: featured1.price,
                                            name: featured1.name),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                              builder: (ctx) => DetailScreen(
                                                image:
                                                    "assets/${featured2.image}",
                                                price: featured2.price,
                                                name: featured2.name,
                                                description:
                                                    featured2.description,
                                                condition: featured2.condition,
                                                used: featured2.used,
                                              ),
                                            ),
                                          );
                                        },
                                        child: SingleProduct(
                                            image: featured2.image,
                                            price: featured2.price,
                                            name: featured2.name),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Container(
                            height: 50,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "New Arrival",
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
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
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.of(context)
                                                .pushReplacement(
                                              MaterialPageRoute(
                                                builder: (ctx) => DetailScreen(
                                                  image: "assets/${new1.image}",
                                                  price: new1.price,
                                                  name: new1.name,
                                                  description: new1.description,
                                                  condition: new1.condition,
                                                  used: new1.used,
                                                ),
                                              ),
                                            );
                                          },
                                          child: SingleProduct(
                                              image: new1.image,
                                              price: new1.price,
                                              name: new1.name),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.of(context)
                                                .pushReplacement(
                                              MaterialPageRoute(
                                                builder: (ctx) => DetailScreen(
                                                  image: "assets/${new2.image}",
                                                  price: new2.price,
                                                  name: new2.name,
                                                  description: new2.description,
                                                  condition: new2.condition,
                                                  used: new2.used,
                                                ),
                                              ),
                                            );
                                          },
                                          child: SingleProduct(
                                              image: new2.image,
                                              price: new2.price,
                                              name: new2.name),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Divider(color: Colors.pinkAccent),
                          Container(
                            padding: EdgeInsets.only(top: 18),
                            height: 60,
                            width: double.infinity,
                            child: Text(
                              '© Copyright 2022 Bundle+, Inc',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.pinkAccent,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
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

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}
