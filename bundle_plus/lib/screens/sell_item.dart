import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/user_model.dart';
import '../model/item_model.dart';
import 'home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SellItems extends StatefulWidget {
  const SellItems({Key? key}) : super(key: key);

  @override
  _SellItemState createState() => _SellItemState();
}

class _SellItemState extends State<SellItems> {
  final _auth = FirebaseAuth.instance;

  // string for displaying the error Message
  String? errorMessage;

  // our form key
  final _formKey = GlobalKey<FormState>();
  // editing Controller
  final nameEditingController = new TextEditingController();
  final descriptionEditingController = new TextEditingController();
  final categoryEditingController = new TextEditingController();
  final priceEditingController = new TextEditingController();

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Category"), value: ""),
      DropdownMenuItem(child: Text("Books"), value: "Books"),
      DropdownMenuItem(child: Text("Electronics"), value: "Electronics"),
      DropdownMenuItem(child: Text("Foods"), value: "Foods"),
      DropdownMenuItem(child: Text("Sports"), value: "Sports"),
      DropdownMenuItem(child: Text("Accesories"), value: "Accesories"),
    ];
    return menuItems;
  }

  String selectedValue = "Category";

  @override
  Widget build(BuildContext context) {
    //name field
    final nameField = TextFormField(
        autofocus: false,
        cursorColor: Colors.pinkAccent,
        controller: nameEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Name cannot be Empty");
          }
          return null;
        },
        onSaved: (value) {
          nameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.abc,
            color: Colors.pinkAccent,
          ),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.pinkAccent, width: 2.0),
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //description field
    final descriptionField = TextFormField(
        autofocus: false,
        cursorColor: Colors.pinkAccent,
        controller: descriptionEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Description cannot be Empty");
          }
          return null;
        },
        onSaved: (value) {
          descriptionEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.description,
            color: Colors.pinkAccent,
          ),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Description",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.pinkAccent, width: 2.0),
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //category field

    final categoryField = DropdownButtonFormField(
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.category,
            color: Colors.pinkAccent,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.pinkAccent, width: 2.0),
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        ),
        value: selectedValue,
        validator: (value) {
          if (value=="") {
            return ("Select an Category");
          }
          return null;
        },
        onSaved: (String? newValue) {
          categoryEditingController.text = newValue!;
        },
        onChanged: (String? newValue) {
          setState(() {
            categoryEditingController.text = newValue!;
          });
        },
        items: dropdownItems);

    // final categoryField = TextFormField(
    //     autofocus: false,
    //     cursorColor: Colors.pinkAccent,
    //     controller: categoryEditingController,
    //     keyboardType: TextInputType.name,
    //     validator: (value) {
    //       RegExp regex = RegExp(r'^.{3,}$');
    //       if (value!.isEmpty) {
    //         return ("Name cannot be Empty");
    //       }
    //       if (!regex.hasMatch(value)) {
    //         return ("Enter Valid name(Min. 3 Character)");
    //       }
    //       return null;
    //     },
    //     onSaved: (value) {
    //       categoryEditingController.text = value!;
    //     },
    //     textInputAction: TextInputAction.next,
    //     decoration: InputDecoration(
    //       prefixIcon: const Icon(
    //         Icons.category,
    //         color: Colors.pinkAccent,
    //       ),
    //       contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
    //       hintText: "Category",
    //       border: OutlineInputBorder(
    //         borderRadius: BorderRadius.circular(10),
    //       ),
    //       focusedBorder: OutlineInputBorder(
    //         borderSide: const BorderSide(color: Colors.pinkAccent, width: 2.0),
    //         borderRadius: BorderRadius.circular(10),
    //       ),
    //     ));

    //price field
    final priceField = TextFormField(
        autofocus: false,
        cursorColor: Colors.pinkAccent,
        controller: priceEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Price cannot be Empty");
          }
          return null;
        },
        onSaved: (value) {
          priceEditingController.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.price_check,
            color: Colors.pinkAccent,
          ),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Price",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.pinkAccent, width: 2.0),
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //signup button
    final addItemButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.pinkAccent,
      child: MaterialButton(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            postDetailsToFirestore();
          },
          child: const Text(
            "Add Item",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const HomeScreen()));
          },
        ),
        backgroundColor: Colors.white,
      ),
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
                    const SizedBox(height: 45),
                    nameField,
                    const SizedBox(height: 20),
                    descriptionField,
                    const SizedBox(height: 20),
                    categoryField,
                    const SizedBox(height: 20),
                    priceField,
                    const SizedBox(height: 20),
                    addItemButton,
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sedning these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    final docItem = FirebaseFirestore.instance.collection('items').doc();
    
    ItemModel itemModel = ItemModel();

    // writing all the values
    itemModel.iid = docItem.id;
    itemModel.name = nameEditingController.text;
    itemModel.description = descriptionEditingController.text;
    itemModel.category = categoryEditingController.text;
    itemModel.price = priceEditingController.text;

    await docItem.set(itemModel.toMap());
    Fluttertoast.showToast(msg: "Item added successfully :) ");

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => const HomeScreen()),
        (route) => false);
  }
}
