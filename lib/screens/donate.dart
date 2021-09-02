import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ktracker/initialPages/home.dart';

class ThanksDonation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    height: 20,
                  ),
                  Text(
                    ' Stand with Kerala ',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'Kerala is in a battle against COVID19.'
                    ' The people of the State have shown great courage and tenacity in'
                    ' this fight against the pandemic. The outbreak and the consequent '
                    'disruption have affected the lives of many. You can help rebuild the'
                    ' affected lives by making contributions to the Chief Ministers Distress Relief Fund (CMDRF). ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey[900],
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 3,
                  ),
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height / 4,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('assets/images/thankspay.png'),
                )),
              ),
              Column(
                children: [
                  MaterialButton(
                      minWidth: 40,
                      height: 40,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
                      },
                      color: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Back To Home  ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                            WidgetSpan(
                              child: Icon(
                                Icons.home,
                                size: 20,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      )

                      // Text(
                      //   'Back',
                      //   style: TextStyle(
                      //     fontSize: 20,
                      //     fontWeight: FontWeight.w600,
                      //     color: Colors.white,
                      //   ),
                      // ),
                      ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
