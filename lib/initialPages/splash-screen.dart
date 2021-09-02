import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  bool loaded = false;

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
        Stack(
          children: [
            Positioned.fill(child: Image.asset('assets/images/unsplash.png',fit: BoxFit.fill,)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 5
                  ,child: Container(),),
                Image.asset('assets/images/fightco.png',height: 120,),
                Expanded(
                  flex:5,child: Container(),),
                Image.asset('assets/images/ticks.png',height: 60,),
                Expanded(
                  flex: 1,child: Container(),),

              ],
            )
          ],
        )
    );
  }

  startTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, () {
      isLoggedIn ? navigationPage('/homeScreen') : navigationPage('/Onbording');
    });
  }

  void navigationPage(String destination) {
    Navigator.of(context).pushReplacementNamed(destination);
  }

}