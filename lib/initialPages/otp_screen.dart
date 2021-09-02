// import 'dart:async';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/services.dart';
// import 'package:otp_count_down/otp_count_down.dart';
// import 'package:pin_entry_text_field/pin_entry_text_field.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:toast/toast.dart';
//
// // ignore: must_be_immutable
// class OtpScreen extends StatefulWidget {
//   bool _isInit = true;
//   var _contact = '';
//
//   @override
//   _OtpScreenState createState() => _OtpScreenState();
// }
//
// class _OtpScreenState extends State<OtpScreen> {
//   String phoneNo;
//   String smsOTP;
//   String verificationId;
//   String errorMessage = '';
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   Timer _timer;
//   String _countDown;
//   OTPCountDown _otpCountDown;
//   final int _otpTimeInMS = 1000 * 60;
//
//   @override
//   void initState() {
//     _startCountDown();
//     super.initState();
//   }
//
//   void _startCountDown() async {
//     _otpCountDown = OTPCountDown.startOTPTimer(
//       timeInMS: _otpTimeInMS,
//       currentCountDown: (String countDown) {
//         _countDown = countDown;
//         setState(() {});
//       },
//       onFinish: () {
//         Toast.show("Otp Expired!", context, duration: 2, gravity: Toast.BOTTOM);
//       },
//     );
//   }
//
//   //this is method is used to initialize data
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     // Load data only once after screen load
//     if (widget._isInit) {
//       widget._contact =
//           '${ModalRoute.of(context).settings.arguments as String}';
//       generateOtp(widget._contact);
//       widget._isInit = false;
//     }
//   }
//
//   //dispose controllers
//   @override
//   void dispose() {
//     _otpCountDown.cancelTimer();
//     super.dispose();
//   }
//
//   //build method for UI
//   @override
//   Widget build(BuildContext context) {
//     //Getting screen height width
//     final screenHeight = MediaQuery.of(context).size.height;
//     final screenWidth = MediaQuery.of(context).size.width;
//     return Scaffold(
//       body: Center(
//         child: SingleChildScrollView(
//           child: Container(
//             padding: const EdgeInsets.all(16.0),
//             width: double.infinity,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SizedBox(
//                   height: screenHeight * 0.10,
//                 ),
//                 Image.asset(
//                   'assets/images/verification.png',
//                   height: screenHeight * 0.3,
//                   fit: BoxFit.contain,
//                 ),
//                 SizedBox(
//                   height: screenHeight * 0.02,
//                 ),
//                 const Text(
//                   'Verification',
//                   style: TextStyle(fontSize: 28, color: Colors.black),
//                 ),
//                 SizedBox(
//                   height: screenHeight * 0.02,
//                 ),
//                 Text(
//                   'Enter A 6 digit number that was sent to ${widget._contact}',
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(
//                     fontSize: 18,
//                     color: Colors.black,
//                   ),
//                 ),
//                 SizedBox(
//                   height: screenHeight * 0.04,
//                 ),
//                 Center(
//                   child: Text(
//                     _countDown,
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: MediaQuery.of(context).size.height * 0.03,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: screenHeight * 0.04,
//                 ),
//                 Container(
//                   margin: EdgeInsets.symmetric(
//                       horizontal: screenWidth > 600 ? screenWidth * 0.2 : 9),
//                   padding: const EdgeInsets.all(16.0),
//                   decoration: BoxDecoration(
//                       color: Colors.white,
//                       // ignore: prefer_const_literals_to_create_immutables
//                       boxShadow: [
//                         const BoxShadow(
//                           color: Colors.grey,
//                           offset: Offset(0.0, 1.0), //(x,y)
//                           blurRadius: 6.0,
//                         ),
//                       ],
//                       borderRadius: BorderRadius.circular(16.0)),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Container(
//                         margin: EdgeInsets.only(left: screenWidth * 0.025),
//                         child: PinEntryTextField(
//                           fields: 6,
//                           onSubmit: (text) {
//                             smsOTP = text as String;
//                           },
//                         ),
//                       ),
//                       SizedBox(
//                         height: screenHeight * 0.04,
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           verifyOtp();
//                         },
//                         child: Container(
//                           margin: const EdgeInsets.all(8),
//                           height: 45,
//                           width: double.infinity,
//                           decoration: BoxDecoration(
//                             color: Colors.teal,
//                             borderRadius: BorderRadius.circular(16),
//                           ),
//                           alignment: Alignment.center,
//                           child: const Text(
//                             'Verify',
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 16.0),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   //Method for generate otp from firebase
//   Future<void> generateOtp(String contact) async {
//     final PhoneCodeSent smsOTPSent = (String verId, [int forceCodeResend]) {
//       verificationId = verId;
//     };
//     try {
//       await _auth.verifyPhoneNumber(
//           phoneNumber: contact,
//           timeout: const Duration(seconds: 60),
//           codeAutoRetrievalTimeout: (String verId) {
//             verificationId = verId;
//           },
//           codeSent: smsOTPSent,
//           verificationCompleted: (AuthCredential phoneAuthCredential) async {
//             await _auth.signInWithCredential(phoneAuthCredential);
//             print(
//                 "Phone number automatically verified and user signed in: ${_auth.currentUser.uid}");
//           },
//           verificationFailed: (FirebaseAuthException e) {
//             // Navigator.pop(context, exception.message);
//             if (e.code == 'invalid-phone-number') {
//               print('The provided phone number is not valid.');
//             }
//           });
//     } catch (e) {
//       handleError(e as FirebaseAuthException);
//       Navigator.pop(context, (e as PlatformException).message);
//     }
//   }
//
//   setAsLoggedIn(bool status) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setBool('isLoggedIn', status);
//   }
//
//   //Method for verify otp entered by user
//   Future<void> verifyOtp() async {
//     if (smsOTP == null || smsOTP == '') {
//       showAlertDialog(context, 'please enter 6 digit otp');
//       return;
//     }
//     try {
//       final AuthCredential credential = PhoneAuthProvider.credential(
//         verificationId: verificationId,
//         smsCode: smsOTP,
//       );
//       final UserCredential user = await _auth.signInWithCredential(credential);
//       await _auth.signInWithCredential(credential);
//       print('verified');
//       final User currentUser = await _auth.currentUser;
//       assert(user.user.uid == currentUser.uid);
//       loginSuccess();
//
//       // Navigator.push(context,
//       //     MaterialPageRoute(builder: (context) => HomeScreen()));
//     } catch (e) {
//       handleError(e as FirebaseAuthException);
//     }
//   }
//
//   loginSuccess() async {
//     setAsLoggedIn(true);
//     Navigator.pushReplacementNamed(context, '/homeScreen');
//   }
//
//   //Method for handle the errors
//   void handleError(FirebaseAuthException error) {
//     switch (error.code) {
//       case 'ERROR_INVALID_VERIFICATION_CODE':
//         FocusScope.of(context).requestFocus(FocusNode());
//         setState(() {
//           errorMessage = 'Invalid Code';
//         });
//         showAlertDialog(context, 'Invalid Code');
//         break;
//       default:
//         showAlertDialog(context, error.message);
//         break;
//     }
//   }
//
//   //Basic alert dialogue for alert errors and confirmations
//   void showAlertDialog(BuildContext context, String message) {
//     // set up the AlertDialog
//     final CupertinoAlertDialog alert = CupertinoAlertDialog(
//       title: const Text('Error'),
//       content: Text('\n$message'),
//       actions: <Widget>[
//         CupertinoDialogAction(
//           isDefaultAction: true,
//           child: const Text('Ok'),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         )
//       ],
//     );
//     // show the dialog
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return alert;
//       },
//     );
//   }
// }
