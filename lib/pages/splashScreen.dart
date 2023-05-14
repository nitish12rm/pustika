import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pustika/pages/homePage.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({Key? key}) : super(key: key);

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), () {
      setState(() {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => homePage()));

      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage("lib/asset/60105988580.png"),
              radius: 60,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Pusktika",
              style: TextStyle(
                fontSize: 20,
              ),
            )
          ],
        ),
      ),
    );
  }
}
