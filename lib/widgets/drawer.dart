// import 'package:http/http.dart' as http;
// import 'package:ktrack19/initialPages/home.dart';
// import 'package:ktrack19/screens/about.dart';
// import 'package:ktrack19/screens/emergency_contacts.dart';
// import 'package:ktrack19/screens/profile.dart';
// import 'package:ktrack19/vaccine/Explore.dart';
// import 'package:ktrack19/vaccine/vaccine_slot.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// class ss extends StatefulWidget {
//   const ss({Key? key}) : super(key: key);
//
//   @override
//   _ssState createState() => _ssState();
// }
//
// class _ssState extends State<ss> {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//     drawer: Drawer(
//       child: ListView(
//         // Important: Remove any padding from the ListView.
//         padding: EdgeInsets.zero,
//         children: <Widget>[
//           Padding(
//             padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
//             child: DrawerHeader(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 image: DecorationImage(
//                   image: AssetImage("assets/images/drawer.png"),
//                 ),
//                 // color: Colors.teal,
//               ),
//             ),
//           ),
//           Center(
//             child: Text(
//               'Hi ',
//               style: TextStyle(
//                 fontWeight: FontWeight.w600,
//                 fontSize: 20,
//               ),
//             ),
//           ),
//           ListTile(
//             title: Text('💉 Get Vaccinated'),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => GetVaccinated()),
//               );
//             },
//           ),
//           ListTile(
//             title: Text('🏥 Find Vaccine Slot'),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => VaccineSlot()),
//               );
//             },
//           ),
//           ListTile(
//             title: Text('🚨 Emergency contacts'),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => EmergencyContact()),
//               );
//             },
//           ),
//           ListTile(
//             title: Text('💰 Donate'),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => PaymentPage()),
//               );
//             },
//           ),
//           ListTile(
//             title: Text('👨 Profile'),
//             onTap: () async {
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => EditProfilePage()));
//             },
//           ),
//           ListTile(
//             title: Text('🧑‍💻 About Us'),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => AboutPage()),
//               );
//             },
//           ),
//           ListTile(
//             title: Text('🥺 Logout'),
//             onTap: () {
//               showAlertDialog(context, 'LogOut');
//             },
//           ),
//           SizedBox(
//             height: 5.0,
//           ),
//           Column(
//             children: [
//               Text('V0.0.01'),
//               IconButton(
//                   icon: Icon(Icons.code_outlined),
//                   onPressed: () async {
//                     const url = 'https://github.com/muhd-ameen/ktrack19';
//                     if (await canLaunch(url)) {
//                       await launch(url);
//                     } else {
//                       throw 'Could not launch $url';
//                     }
//
//                     print('Link Opened');
//                   }),
//             ],
//           ),
//         ],
//       ),
//     ),
//   }
// }
