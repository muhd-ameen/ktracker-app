// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:ktrack19/initialPages/home.dart';
// import 'package:ktrack19/vaccine/vaccine_registration.dart';
//
//
// class RegisSuccess extends StatelessWidget {
//
// final vaccineReg = VaccineRegister();
//
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {},
//       child: Scaffold(
//         body: SafeArea(
//           child: Container(
//             width: double.infinity,
//             height: MediaQuery.of(context).size.height,
//             padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Column(
//                   children: [
//                     SizedBox(
//                       height: 80,
//                     ),
//                     Center(
//                       child: Text(
//                         'Covid-19 Registration Successful',
//                         style: TextStyle(
//                             fontSize: 30, fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 20.0,
//                     ),
//                     Text(
//                       'Will Get Vaccine Availability to Your Phone Number',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         color: Colors.grey[900],
//                         fontSize: 15,
//                       ),
//                     ),
//                     SizedBox(
//                       height: 3,
//                     ),
//                   ],
//                 ),
//                 Container(
//                   height: MediaQuery.of(context).size.height / 3,
//                   decoration: BoxDecoration(
//                       image: DecorationImage(
//                     image: AssetImage('assets/images/fightco.png'),
//                   )),
//                 ),
//                 Column(
//                   children: [
//                     IconButton(
//                       color: Colors.teal[700],
//                       icon: const Icon(Icons.done_all_outlined,size: 35,),
//                       tooltip: 'Get Started',
//                       onPressed: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => HomeScreen()));
//                         print("HomeScreen");
//                       },
//                     ),
//
//
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
