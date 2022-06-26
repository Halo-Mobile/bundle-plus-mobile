import 'package:bundle_plus/model/order_model.dart';
import 'package:bundle_plus/screens/home.dart';
import 'package:bundle_plus/screens/widgets/button_widget.dart';
import 'package:bundle_plus/screens/widgets/item_card.dart';
import 'package:bundle_plus/services/auth_service.dart';
import 'package:bundle_plus/services/firestore_service.dart';
import 'package:bundle_plus/utils/app_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:one_context/one_context.dart';

class CheckoutScreen extends StatefulWidget {
  final String? iid;
  final String? uid;
  final String? image;
  final String? name;
  final String? price;
  CheckoutScreen({
    this.iid,
    this.uid,
    this.image,
    this.name,
    this.price,
  });

  // print(image);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  // initialize firestore_service.dart in services folder
  final FirestoreService _firestoreService = FirestoreService();
  final AuthService _authService = AuthService();


  void sendNotification({String? title, String? body}) async{
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/logo');
  
    const InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);


    const AndroidNotificationChannel channel = AndroidNotificationChannel('high_channel', 'Hight importance notification', description: 'This channel is for important notification', importance: Importance.max);

    flutterLocalNotificationsPlugin.show(0, title, body, NotificationDetails(android: AndroidNotificationDetails(channel.id, channel.name)));
  }
  

  // print(widget.)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Checkout Page",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.pinkAccent,
          ),
          onPressed: () {
            // TODO: Replace the route
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (ctx) => const HomeScreen()));
          },
        ),
      ),
      body: Container(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // MaterialButton(onPressed: hello),
              // Text(prints()),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                child: Text(
                  'Item',
                  style: AppTheme.headline2,
                ),
              ),
              ItemCard(
                itemName: "${widget.name}",
                itemPrice: "RM ${widget.price}",
                itemImage: "${widget.image}",
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                child: Text(
                  'Payment Method',
                  style: AppTheme.headline2,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                // TODO: Implement drop down menu
                padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                child: Text(
                  'Cash on delivery (COD)',
                  style: AppTheme.bodyText1,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                child: Text(
                  'Payment Summary',
                  style: AppTheme.headline2,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Expanded(
                    child: Padding(
                      // TODO: Implement drop down menu
                      padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                      child: Text(
                        'Item price',
                        style: AppTheme.bodyText1,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                    child: Text(
                      'RM ${widget.price}',
                      style: AppTheme.bodyText1,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Expanded(
                    child: Padding(
                      // TODO: Implement drop down menu
                      padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                      child: Text(
                        'Total',
                        style: AppTheme.bodyText1,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                    child: Text(
                      'RM ${widget.price}',
                      style: AppTheme.bodyText1,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Expanded(
                    child: Padding(
                      // TODO: Implement drop down menu
                      padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                      child: Text(
                        'item id',
                        style: AppTheme.bodyText1,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                    child: Text(
                      '${widget.iid}',
                      style: AppTheme.bodyText1,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Expanded(
                    child: Padding(
                      // TODO: Implement drop down menu
                      padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                      child: Text(
                        'seller id',
                        style: AppTheme.bodyText1,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                    child: Text(
                      '${widget.uid}',
                      style: AppTheme.bodyText1,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 220,
              ),
              Align(
                alignment: FractionalOffset.bottomCenter,
                child: ButtonWidget(
                  // button from screens>widgets
                  onPressed: () async {
                    //send notification
                    sendNotification(title: "Bundle+", body: "The seller has been notified for the order");

                    // await _firestoreService.createOrder(widget.name.toString(), widget.iid.toString(), widget.uid.toString());
                    await _firestoreService.createOrder(Order(
                        name: widget.name.toString(),
                        paymentMethod: "COD",
                        status: "Pending",
                        date: DateFormat.yMMMd().format(DateTime.now()),
                        time: DateFormat('hh:mm:ss').format(DateTime.now()),
                        uid: _authService.currentUser.uid,
                        iid: widget.iid.toString(),
                        sid: widget.uid
                            .toString() // NOTE: why uid? uid = user id, check back
                        // oid: _firestoreService  // NOTE : differnt from the real id
                        //     .getOrderId()
                        // .toString()
                        ));
                    // await _firestoreService.getOrderId();
                    if (OneContext.hasContext) {
                      // copy this to show dialog
                      await OneContext().showDialog(
                          builder: (_) => AlertDialog(
                                  title:
                                      new Text("Order successfully created!"),
                                  content: new Text(
                                      "Your order has been successfully created. You can view your order in Order History from the sidebar."),
                                  actions: <Widget>[
                                    new TextButton(
                                        child: new Text("OK"),
                                        onPressed: () =>
                                            OneContext().popDialog('ok')),
                                  ]));
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen()));
                    }
                  },
                  textButton: "Create Order",
                ),
              ),
            ]),
      ),
    );
  }

  // void hello() {
  //   print(widget.image);
  //   print('fe');
  // }
}
