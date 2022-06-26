import 'package:bundle_plus/model/order_model.dart';
import 'package:bundle_plus/model/user_model.dart';
import 'package:bundle_plus/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UpdateOrderr extends StatefulWidget {
  final String? oid;
  final String? uid;
  final String? iid;
  final String? sid; //seller id
  final String? name;
  final String? status;
  final String? paymentMethod;
  final String? time;
  final String? date;

  UpdateOrderr({
    this.oid,
    this.uid,
    this.iid,
    this.sid, //seller id
    this.name,
    this.status,
    this.paymentMethod,
    this.time,
    this.date,
  });
  // const UpdateOrderr({Key? key}) : super(key: key);

  @override
  _UpdateOrderrState createState() => _UpdateOrderrState();
}

class _UpdateOrderrState extends State<UpdateOrderr> {
  late String dropdownValue = 'Pending';
  UserModel loggedInUser = UserModel();
  User? user = FirebaseAuth.instance.currentUser;

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
        backgroundColor: Color(0xfff8f8f8),
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Update Order Status",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
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
                Icons.check,
                color: Colors.black,
              ),
              onPressed: () {
                postDetailsToFirestore();
              },
            )
          ],
        ),
        body: Center(
          // width: double.infinity,
          // padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: DropdownButton(
            value: dropdownValue,
            icon: const Icon(Icons.arrow_downward),
            elevation: 16,
            style: const TextStyle(color: Colors.pinkAccent),
            underline: Container(
              height: 2,
              color: Colors.pinkAccent,
            ),
            onChanged: (String? newValue) async {
              setState(() {
                dropdownValue = newValue!;
              });
            },
            items: <String>['Pending', 'Preparing Order', 'Delivered']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ));
  }

  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sending these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    Order updateOrder = new Order();

    updateOrder.oid = widget.oid;
    updateOrder.iid = widget.iid;
    updateOrder.uid = widget.uid;
    updateOrder.sid = loggedInUser.uid;
    updateOrder.name = widget.name;
    updateOrder.status = dropdownValue;
    updateOrder.paymentMethod = widget.paymentMethod;
    updateOrder.date = widget.date;
    updateOrder.time = widget.time;

    await firebaseFirestore
        .collection("orders")
        // .where("uid", isEqualTo: widget.uid)
        // .where("iid", isEqualTo: widget.iid)
        // .where("sid", isEqualTo: widget.sid)
        .doc(widget.oid)
        .update(updateOrder.toMap());
    // DatabaseReference ref = FirebaseDatabase.instance.ref("orders/")
    Fluttertoast.showToast(msg: "Order updated successfully :) ");

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => const HomeScreen()),
        (route) => false);
  }
}
