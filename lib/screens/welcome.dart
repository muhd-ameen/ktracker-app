import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ktracker/initialPages/home.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {},
      child: Scaffold(
        body: SafeArea(
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 80,
                    ),
                    Center(
                      child: Text(
                        'Welcome To ktrack19',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'The Complete Covid-19 Tracker For Kerala',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey[900],
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                  ],
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 3,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage('assets/images/fightco.png'),
                  )),
                ),
                Column(
                  children: [
                    IconButton(
                      color: Colors.teal[700],
                      icon: const Icon(Icons.arrow_forward_ios_rounded),
                      tooltip: 'Get Started',
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()));
                        print("HomeScreen");
                      },
                    ),

                    // MaterialButton(
                    //   minWidth: 40,
                    //   height: 40,
                    //   onPressed: (){
                    //     Navigator.push(
                    //         context, MaterialPageRoute(builder: (context) => HomeScreen()));
                    //     print("HomeScreen");
                    //   },
                    //   color: Colors.teal[600],
                    //   shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(50),
                    //   ),
                    //
                    //   child: Text(
                    //     '  Get Started  ',
                    //     style: TextStyle(
                    //       fontSize: 20,
                    //       fontWeight: FontWeight.w600,
                    //       color: Colors.white,
                    //     ),
                    //
                    //   ),
                    //
                    // ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
