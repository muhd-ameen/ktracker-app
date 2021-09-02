// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ktracker/constants.dart';
import 'package:ktracker/Apis/apis/Summary-api.dart';
import 'package:ktracker/covid-updates/Death-Cases.dart';
import 'package:ktracker/covid-updates/confirmed-cases.dart';
import 'package:ktracker/covid-updates/recovered-cases.dart';
import 'package:ktracker/screens/about.dart';
import 'package:ktracker/screens/emergency_contacts.dart';
import 'package:ktracker/screens/payment.dart';
import 'package:ktracker/screens/profile.dart';
import 'package:ktracker/screens/utils/user_simple_prefereences.dart';
import 'package:ktracker/vaccine/Explore.dart';
import 'package:ktracker/vaccine/vaccine_slot.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ktracker/covid-updates/Actice-Cases.dart';
import 'package:ktracker/widgets/info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  ProfilePage profilePage = ProfilePage();

  SummaryData summaryData = SummaryData();
  String dataRecieveds;
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
        dataRecieveds = summaryData.summary.active.toString();
      });
      print('${districtResponse.body}');
    } else {
      throw Exception('Failed to load data!');
    }
  }

  //location
  // Position _position;
  // StreamSubscription<Position> _streamSubscription;
  // Address _address;
  //
  // void location() {
  //   var locationOption =
  //       LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);
  //   _streamSubscription = Geolocator()
  //       .getPositionStream(locationOption)
  //       .listen((Position position) {
  //     setState(() {
  //       print(position);
  //       _position = position;
  //       final coordinates =
  //           new Coordinates(position.latitude, position.longitude);
  //       convertCoordinatesToAddress(coordinates)
  //           .then((value) => _address = value);
  //     });
  //   });
  // }
  //
  // Future<Address> convertCoordinatesToAddress(Coordinates coordinates) async {
  //   var addresses =
  //       await Geocoder.local.findAddressesFromCoordinates(coordinates);
  //   return addresses.first;
  // }
  //location

  String fnickname = '';
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // location();
      await geSummaryData();
      fnickname = UserSimplePreferences.getNickname() ?? '';
    });
  }

  @override
  void dispose() {
    super.dispose();
    // _streamSubscription.cancel();
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7), child: Text("  Working...")),
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
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
      },
      child: SafeArea(
        top: false,
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Center(
                child: Text(
              'Ktracker',
              style: TextStyle(
                  color: Colors.teal[800], fontWeight: FontWeight.w700),
            )),
            backgroundColor: kBackgroundColor,
            elevation: 0,
            leading: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.grain_sharp,
                      color: Colors.teal[700], size: 30),
                  onPressed: () {
                    _scaffoldKey.currentState.openDrawer();
                  },
                ),
              ],
            ),
            actions: <Widget>[
              IconButton(
                padding: EdgeInsets.only(right: 20),
                icon: Icon(FontAwesomeIcons.powerOff),
                color: Colors.black45,
                iconSize: 20,
                onPressed: () {
                  showAlertDialog(context, 'LogOut');
                },
              ),
            ],
          ),
          body: dataRecieveds == null
              ? Text('')
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.only(
                            left: 20, top: 20, right: 20, bottom: 20),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: kPrimaryColor.withOpacity(0.03),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(50),
                            bottomRight: Radius.circular(50),
                          ),
                        ),
                        child: Wrap(
                          runSpacing: 20,
                          spacing: 20,
                          children: <Widget>[
                            InfoCard(
                              title: "Confirmed Cases",
                              iconColor: Color(0xFFFF8C00),
                              effectedNum: summaryData.summary.confirmed,
                              press: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return ConfirmedCases();
                                    },
                                  ),
                                );
                              },
                            ),
                            InfoCard(
                              title: "Total Deaths",
                              iconColor: Color(0xFFFF2D55),
                              effectedNum: summaryData.summary.deceased,
                              press: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return DeathCases();
                                    },
                                  ),
                                );
                              },
                            ),
                            InfoCard(
                              title: "Total Recovered",
                              iconColor: Color(0xFF50E3C2),
                              effectedNum: summaryData.summary.recovered,
                              press: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return RecoveredCases();
                                    },
                                  ),
                                );
                              },
                            ),
                            InfoCard(
                              title: "Active Cases",
                              iconColor: Color(0xFF5856D6),
                              effectedNum: summaryData.summary.active,
                              press: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return ActiveCases();
                                    },
                                  ),
                                );
                              },
                            ),
                            Center(
                                child: Column(
                              children: [
                                Text(
                                    'Last Updated ${summaryData.lastUpdated.toUpperCase()}'),
                              ],
                            )),
                          ],
                        ),
                      ),
                      SizedBox(height: 13),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Preventions",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 15),
                              buildPreventation(),
                              SizedBox(height: 40),
                              buildHelpCard(context),
                              SizedBox(height: 15),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              const url = 'tel:1056';
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            },
            child: const Icon(
              Icons.call,
              color: Colors.white,
              size: 27,
            ),
            backgroundColor: Colors.teal[700],
            tooltip: 'Emergency Call',
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
                    'Hi $fnickname',
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
                  leading: const Icon(FontAwesomeIcons.firstAid),
                  title: const Text('Emergency contacts'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => emergencyContacts()),
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditProfilePage()));
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
                      },
                    ),
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

void showAlertDialog(BuildContext context, String s) {
  // set up the AlertDialog
  final CupertinoAlertDialog alert = CupertinoAlertDialog(
    title: const Text('Alert'),
    content: Text('Do you want To Logout?'),
    actions: <Widget>[
      CupertinoDialogAction(
        isDefaultAction: true,
        child: const Text(
          'Log out',
          style: TextStyle(color: Colors.red),
        ),
        onPressed: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          try {
            prefs.remove("isLoggedIn");
            await prefs.clear();
            Navigator.pushNamedAndRemoveUntil(
                context, '/Onbording', (Route<dynamic> route) => false);
          } catch (e) {
            print(e);
          }
        },
      )
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

Row buildPreventation() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      PreventitonCard(
        svgSrc: "assets/icons/hand_wash.svg",
        title: "Wash Hands",
      ),
      PreventitonCard(
        svgSrc: "assets/icons/use_mask.svg",
        title: "Use Masks",
      ),
      PreventitonCard(
        svgSrc: "assets/icons/Clean_Disinfect.svg",
        title: "Clean Disinfect",
      ),
    ],
  );
}

Container buildHelpCard(BuildContext context) {
  return Container(
    height: 120,
    width: double.infinity,
    child: Stack(
      alignment: Alignment.bottomLeft,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            // left side padding is 40% of total width
            left: MediaQuery.of(context).size.width * .4,
            top: 20,
            right: 20,
          ),
          height: 130,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFF60BE93),
                Color(0xFF1B8D59),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Dial 1056 for \nMedical Help!\n",
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(color: Colors.white),
                ),
                TextSpan(
                  text: "If any symptoms appear",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SvgPicture.asset("assets/icons/nurse.svg"),
        ),
        Positioned(
          top: 30,
          right: 10,
          child: SvgPicture.asset("assets/icons/virus.svg"),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    ),
  );
}

class PreventitonCard extends StatelessWidget {
  final String svgSrc;
  final String title;
  const PreventitonCard({
    Key key,
    this.svgSrc,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SvgPicture.asset(svgSrc),
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(color: kPrimaryColor),
        )
      ],
    );
  }
}
