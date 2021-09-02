import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ktracker/screens/payment.dart';

import '../constants.dart';

class emergencyContacts extends StatefulWidget {
  @override
  _emergencyContactsState createState() => _emergencyContactsState();
}

class _emergencyContactsState extends State<emergencyContacts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: kPrimaryColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.redeem_rounded),
            color: Colors.teal,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return PaymentPage();
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 21),
                      blurRadius: 53,
                      color: Colors.black.withOpacity(0.05),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Emergency Contact Numbers",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Press Call Icon to Call",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              callCard(
                ServiceName: 'Ambulance',
                number: 'tel:108',
              ),
              callCard(
                ServiceName: 'Disha(Toll Free)',
                number: 'tel:1056',
              ),
              callCard(
                ServiceName: 'State Helpline',
                number: 'tel:1056',
              ),
              callCard(
                ServiceName: 'Child Helpline',
                number: 'tel:tel:1098',
              ),
              callCard(
                ServiceName: 'Women Helpline',
                number: 'tel:1091',
              ),
              callCard(
                ServiceName: 'Fire Station',
                number: 'tel:101',
              ),
              callCard(
                ServiceName: 'Indian Coast Guard',
                number: 'tel:1554',
              ),
              callCard(
                ServiceName: 'Disaster Helpline',
                number: 'tel:1070',
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    SvgPicture.asset(
                      "assets/icons/call.svg",
                      width: 300,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class callCard extends StatelessWidget {
  const callCard({@required this.ServiceName, this.number});

  final String ServiceName;
  final String number;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 21),
              blurRadius: 53,
              color: Colors.black.withOpacity(0.05),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              ServiceName.toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: Colors.teal,
                fontSize: 13,
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.call,
              ),
              onPressed: () async {
                final url = number;
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  throw 'Could not launch $url';
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
