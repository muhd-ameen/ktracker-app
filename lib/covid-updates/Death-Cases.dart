import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:ktracker/Apis/apis/Summary-api.dart';
import 'package:ktracker/constants.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ktracker/Apis/apis/District-wise.dart';

import 'package:ktracker/screens/payment.dart';
import 'package:ktracker/initialPages/home.dart';
import 'package:ktracker/screens/about.dart';
import 'package:ktracker/screens/emergency_contacts.dart';
import 'package:ktracker/screens/profile.dart';
import 'package:ktracker/vaccine/Explore.dart';
import 'package:ktracker/vaccine/vaccine_slot.dart';
import 'package:url_launcher/url_launcher.dart';

class DeathCases extends StatefulWidget {
  @override
  _DeathCasesState createState() => _DeathCasesState();
}

String dataRecievedsd;
String Palakkadd;
String Malappuramd;
String Pathanamthittad;
String Wayanadd;
String Thiruvananthapuramd;
String Kannurd;
String Thrissurd;
String Kottayamd;
String Kollamd;
String Idukkid;
String Ernakulamd;
String Alappuzhad;
String Kozhikoded;
String Kasaragodd;
String Summaryvalued;
String lastUpdated;

class _DeathCasesState extends State<DeathCases> {
  DistrictWise latestData = DistrictWise();
  SummaryData summaryData = SummaryData();

  // ignore: missing_return
  Future<List<DistrictWise>> getDistrictWise() async {
    showLoaderDialog(context);
    var baseUrl = 'https://keralastats.coronasafe.live';
    var districtUrl = '$baseUrl/latest.json';
    var districtResponse = await http.get(districtUrl);
    Navigator.pop(context);
    var responseJson = json.decode(districtResponse.body);
    latestData = DistrictWise.fromJson(responseJson);
    if (districtResponse.statusCode == 200) {
      print('Status ${districtResponse.statusCode}');
      setState(() {
        dataRecievedsd = latestData.summary.palakkad.active.toString();
        Thrissurd = latestData.summary.thrissur.active.toString();
        Palakkadd = latestData.summary.palakkad.active.toString();
        Malappuramd = latestData.summary.malappuram.active.toString();
        Ernakulamd = latestData.summary.ernakulam.active.toString();
        Kozhikoded = latestData.summary.kozhikode.active.toString();
        Kannurd = latestData.summary.kannur.active.toString();
        Kasaragodd = latestData.summary.kasaragod.active.toString();
        Idukkid = latestData.summary.idukki.active.toString();
        Kottayamd = latestData.summary.kottayam.active.toString();
        Thiruvananthapuramd =
            latestData.summary.thiruvananthapuram.active.toString();
        Pathanamthittad = latestData.summary.pathanamthitta.active.toString();
        Alappuzhad = latestData.summary.alappuzha.active.toString();
        Wayanadd = latestData.summary.wayanad.active.toString();
        Kollamd = latestData.summary.kollam.active.toString();
      });
      print('${districtResponse.body}');
    } else {
      throw Exception('Failed to load data!');
    }
  }

  Future<List<SummaryData>> geSummaryData() async {
    showLoaderDialog(context);
    var baseUrl = 'https://keralastats.coronasafe.live';
    var districtUrl = '$baseUrl/summary.json';
    var districtResponse = await http.get(districtUrl);
    Navigator.pop(context);
    var responseJson = json.decode(districtResponse.body);
    summaryData = SummaryData.fromJson(responseJson);
    if (districtResponse.statusCode == 200) {
      print('Status ${districtResponse.statusCode}');
      setState(() {
        Summaryvalued = summaryData.summary.active.toString();
        lastUpdated = summaryData.lastUpdated.toString();
      });
      print('${districtResponse.body}');
    } else {
      throw Exception('Failed to load data!');
    }
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7), child: Text("  Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (dataRecievedsd == null) {
        await getDistrictWise();
        await geSummaryData();
      }
    });
  }

  Widget dataBox(String district, String api) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
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
              district.toUpperCase(),
              style: TextStyle(
                color: kTextMediumColor,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
            Text(
              api,
              style: TextStyle(color: kPrimaryColor),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildDetailsAppBar(context),
      body: dataRecievedsd == null
          ? Container()
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                      decoration: BoxDecoration(
                        color: Colors.teal[700],
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
                          SizedBox(height: 10),
                          // Text('${_address?.subLocality?? '-'}, ${_address?.locality?? '-'}',
                          //   style: TextStyle(
                          //       fontSize: 15,
                          //       fontWeight: FontWeight.bold,
                          //       color: Colors.blueAccent[700]
                          //   ),
                          // ),
                          Text(
                            "Total Deceased Cases",
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 15),
                          buildTitleWithMoreIcon(),
                          SizedBox(height: 15),
                          SizedBox(height: 15),
                          dataRecievedsd == null
                              ? Text('')
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    buildInfoTextWithPercentage(
                                      percentage: "Last Updated",
                                      title: lastUpdated,
                                    ),
                                    buildInfoTextWithPercentage(
                                      percentage: "Total Cases",
                                      title: Summaryvalued,
                                    ),
                                  ],
                                ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    dataBox("Palakkad", Palakkadd),
                    dataBox("Malappuram", Malappuramd),
                    dataBox("Pathanamthitta", Pathanamthittad),
                    dataBox("Wayanad", Wayanadd),
                    dataBox("Thiruvananthapuram", Thiruvananthapuramd),
                    dataBox("Kannur", Kannurd),
                    dataBox("Thrissur", Thrissurd),
                    dataBox("Kottayam", Kottayamd),
                    dataBox("Kollam", Kollamd),
                    dataBox("Idukki", Idukkid),
                    dataBox("Ernakulam", Ernakulamd),
                    dataBox("Alappuzha", Alappuzhad),
                    dataBox("Kozhikode", Kozhikoded),
                    dataBox("Kasaragod", Kasaragodd),
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 21),
                            blurRadius: 54,
                            color: Colors.black.withOpacity(0.05),
                          ),
                        ],
                      ),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Stay Safe !",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SvgPicture.asset(
                            "assets/icons/town.svg",
                            width: 300,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    image: AssetImage("assets/images/drawer.png"),
                  ),
                  // color: Colors.teal,
                ),
                child: null,
              ),
            ),
            Center(
              child: Text(
                'Hi ',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: Colors.deepPurple),
              ),
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.wpexplorer),
              title: Text('Explore'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GetVaccinated()),
                );
              },
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.syringe),
              title: Text('Find Vaccine Slot'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VaccineSlot()),
                );
              },
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.firstAid),
              title: Text('Emergency contacts'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => emergencyContacts()),
                );
              },
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.donate),
              title: Text('Donate'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PaymentPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.userCircle),
              title: Text('Profile'),
              onTap: () async {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EditProfilePage()));
              },
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.userShield),
              title: Text('About Us'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.signOutAlt),
              title: Text('Logout'),
              onTap: () {
                showAlertDialog(context, 'LogOut');
              },
            ),
            SizedBox(
              height: 5.0,
            ),
            Column(
              children: [
                Text('V0.0.01'),
                IconButton(
                    icon: Icon(Icons.code_outlined),
                    onPressed: () async {
                      const url = 'https://github.com/muhd-ameen/ktracker';
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }

                      print('Link Opened');
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  RichText buildInfoTextWithPercentage({String title, String percentage}) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "$percentage \n",
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.w500),
          ),
          TextSpan(
            text: title,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Row buildTitleWithMoreIcon() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "KERALA",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        // Text(
        //   "250.9% ",
        //   style: TextStyle(color: kPrimaryColor),
        // ),
      ],
    );
  }

  AppBar buildDetailsAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: kBackgroundColor,
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
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return PaymentPage();
            }));
          },
        ),
      ],
    );
  }
}
