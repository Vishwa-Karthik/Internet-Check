import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_conn/second_page.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late StreamSubscription subscription;

  var isDeviceConn = false;

  bool isAlert = false;

  @override
  void initState() {
    getConnectivity();
    super.initState();
  }

  getConnectivity() {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      isDeviceConn = await InternetConnectionChecker().hasConnection;
      if (!isDeviceConn && isAlert == false) {
        showDialogBox();
        setState(() {
          isAlert = true;
        });
      }
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade100,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade200,
        title: const Text(
          "INTERNET CONNECTIVITY",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 15,
        centerTitle: true,
      ),
      body: Center(
          child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              blurRadius: 25,
              spreadRadius: 5.0,
              color: Colors.deepPurple,
            ),
          ],
        ),
        child: ElevatedButton(
          child: const Text("Move Forward"),
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const SecondPage())),
        ),
      )),
    );
  }

  showDialogBox() {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text("No Internet Connection"),
        content: const Text("Please check your internet connectivity"),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              Navigator.pop(context, "Cancel");
              setState(() {
                isAlert = false;
              });
              isDeviceConn = await InternetConnectionChecker().hasConnection;
              if (!isDeviceConn) {
                showDialogBox();
                setState(() {
                  isAlert = true;
                });
              }
            },
            child: const Text("Re-Check"),
          ),
        ],
      ),
    );
  }
}
