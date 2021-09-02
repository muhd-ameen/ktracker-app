import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:otp_count_down/otp_count_down.dart';
import 'package:ktracker/screens/utils/user_simple_prefereences.dart';
import 'package:pin_entry_text_field/pin_entry_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

// ignore: must_be_immutable
class OtpScreen extends StatefulWidget {
  bool _isInit = true;
  var _contact = '';

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  // final _scaffoldKey = GlobalKey<ScaffoldState>();

  String phoneNo;
  String smsOTP;
  String _verificationId;
  String errorMessage = '';
  // final SmsAutoFill _autoFill = SmsAutoFill();
  FirebaseAuth _auth = FirebaseAuth.instance;
  Timer _timer;
  String _countDown;
  OTPCountDown _otpCountDown;
  final int _otpTimeInMS = 1000 * 5 * 12;
  User firebaseUser;
  bool isVerified;
  // String _message;

  bool isLoading;

  String uId;

  String fphone;

  // time in milliseconds for count down
  @override
  void initState() {
    _startCountDown();
    fireBasePhoneAuth(widget._contact);
    super.initState();
    fphone = widget._contact;
  }

  void _startCountDown() {
    _otpCountDown = OTPCountDown.startOTPTimer(
      timeInMS: _otpTimeInMS,
      currentCountDown: (String countDown) {
        _countDown = countDown;
        setState(() {});
      },
      onFinish: () {
        Toast.show("  Otp Expired!  ", context,
            duration: 5, gravity: Toast.BOTTOM);
      },
    );
  }

  //this is method is used to initialize data
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Load data only once after screen load
    if (widget._isInit) {
      widget._contact =
          '${ModalRoute.of(context).settings.arguments as String}';
      fireBasePhoneAuth(widget._contact);
      widget._isInit = false;
    }
  }

  //build method for UI
  @override
  Widget build(BuildContext context) {
    //Getting screen height width
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/verification.png',
                  height: screenHeight * 0.3,
                  fit: BoxFit.contain,
                ),
                const Text(
                  'Verification',
                  style: TextStyle(fontSize: 28, color: Colors.black),
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                Text(
                  'Enter A 6 digit number that was sent to ${widget._contact}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.04,
                ),
                Center(
                  child: _countDown == null
                      ? Text('')
                      : Text(
                          _countDown,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: MediaQuery.of(context).size.height * 0.03,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: screenWidth > 600 ? screenWidth * 0.2 : 9),
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      // ignore: prefer_const_literals_to_create_immutables
                      boxShadow: [
                        const BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 1.0), //(x,y)
                          blurRadius: 6.0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(16.0)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: screenWidth * 0.025),
                        child: PinEntryTextField(
                          fields: 6,
                          onSubmit: (text) {
                            smsOTP = text as String;
                          },
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.04,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (_verificationId != null) {
                            signInWithPhoneNumber(smsOTP);
                          } else {
                            Toast.show('Failed to verify', context,
                                duration: 2, gravity: Toast.BOTTOM);
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.all(8),
                          height: 45,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.teal,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            'Verify',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0),
                          ),
                        ),
                      ),
                      //
                      TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            'Resend Code ?',
                            style: TextStyle(color: Colors.red),
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  //dispose controllers
  @override
  void dispose() {
    _otpCountDown.cancelTimer();
    super.dispose();
  }

  // void showSnackbar(String message) {
  //   _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
  // }

  //Method for generate otp from firebase
  // Future<void> generateOtp(String contact) async {
  //    PhoneCodeSent smsOTPSent =
  //       (String verId, [int forceCodeResend])  {
  //         print('Please check your phone for the verification code.');
  //
  //     verificationId = verId;
  //   };
  //
  //   try {
  //     await _auth.verifyPhoneNumber(
  //         phoneNumber: contact,
  //         timeout: const Duration(seconds: 60),
  //         codeAutoRetrievalTimeout: (String verId) {
  //           verificationId = verId;
  //         },
  //         codeSent: smsOTPSent,
  //         verificationCompleted: (AuthCredential phoneAuthCredential) async {
  //           await _auth.signInWithCredential(phoneAuthCredential);
  //           print(
  //               "Phone number automatically verified and user signed in: ${_auth.currentUser.uid}");
  //         },
  //         verificationFailed: (FirebaseAuthException authException) {
  //           // Navigator.pop(context, exception.message);
  //           if (authException.code == 'invalid-phone-number') {
  //             print(
  //                 'Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}');
  //           }
  //         });
  //   } catch (e) {
  //     handleError(e as FirebaseAuthException);
  //     Navigator.pop(context, (e as PlatformException).message);
  //   }
  // }

  setAsLoggedIn(bool status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', status);
  }

  //Method for verify otp entered by user

  // void _verifyPhoneNumber(String contact) async {
  //   setState(() {
  //     isVerified = true;
  //   });
  //   setState(() {
  //     _message = '';
  //   });
  //   final PhoneVerificationCompleted verificationCompleted =
  //       (AuthCredential phoneAuthCredential) {
  //     _auth.signInWithCredential(phoneAuthCredential);
  //     setState(() {
  //       _message = 'Received phone auth credential: $phoneAuthCredential';
  //     });
  //   };
  //
  //   final PhoneVerificationFailed verificationFailed =
  //       (FirebaseAuthException authException) {
  //     _message = 'Phone number verification failed';
  //   };
  //
  //   final PhoneCodeSent codeSent =
  //       (String verificationId, [int forceResendingToken]) async {
  //     _verificationId = verificationId;
  //   };
  //
  //   final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
  //       (String verificationId) {
  //     _verificationId = verificationId;
  //   };
  //
  //   await _auth.verifyPhoneNumber(
  //       phoneNumber: contact,
  //       timeout: const Duration(seconds: 30),
  //       verificationCompleted: verificationCompleted,
  //       verificationFailed: verificationFailed,
  //       codeSent: codeSent,
  //       codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  // }

  // Example code of how to sign in with phone.
  // void _signInWithPhoneNumber() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   final AuthCredential credential = PhoneAuthProvider.credential(
  //     verificationId: _verificationId,
  //     smsCode: smsOTP,
  //   );
  //   try {
  //     firebaseUser = (await _auth.signInWithCredential(credential)).user;
  //     final User currentUser = await _auth.currentUser;
  //     assert(firebaseUser.uid == currentUser.uid);
  //     if (firebaseUser != null) {
  //       print('Sign in Success');
  //     } else {
  //       _message = 'Sign in failed';
  //       showAlertDialog(context, 'Invalid Code');
  //     }
  //   } catch (e) {
  //     showAlertDialog(context, 'Invalid Code');
  //   }
  //   setState(() {
  //     isLoading = false;
  //   });
  // }

  // Future<void> verifyOtp() async {
  //   if (smsOTP == null || smsOTP == '') {
  //     showAlertDialog(context, 'please enter 6 digit otp');
  //     return;
  //   }
  //   try {
  //     final PhoneAuthCredential credential = PhoneAuthProvider.credential(
  //       verificationId: verificationId,
  //       smsCode: smsOTP,
  //     );
  //     Toast.show("Verifing..", context,
  //         duration: 4, gravity: Toast.BOTTOM);
  //
  //     final UserCredential user = await _auth.signInWithCredential(credential);
  //     await _auth.signInWithCredential(credential);
  //     print("Successfully signed in UID: ${user.credential}");
  //     Toast.show("Successfully signed in UID: ${user.credential}", context,
  //         duration: 4, gravity: Toast.BOTTOM);
  //     print('verified');
  //     final User currentUser = await _auth.currentUser;
  //     assert(user.user.uid == currentUser.uid);
  //     loginSuccess();
  //   } catch (e) {
  //     print("Failed to sign in: " + e.toString());
  //     handleError(e as FirebaseAuthException);
  //   }
  // }
  // void showSnackbar(String message) {
  //   _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
  // }

  Future fireBasePhoneAuth(String contact) async {
    Toast.show("verifing", context, duration: 2, gravity: Toast.BOTTOM);
    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) async {
      await _auth.signInWithCredential(phoneAuthCredential);
      Toast.show(
          "Phone number automatically verified and user signed in: ${_auth.currentUser.uid}",
          context,
          duration: 2,
          gravity: Toast.BOTTOM);
      setState(() {
        uId = _auth.currentUser.uid.toString();
      });
      loginSuccess();
    };

    PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      // Toast.show(
      //     'Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}',
      //     context,
      //     duration: 2,
      //     gravity: Toast.BOTTOM);
      print(authException.code);
      print(authException.message);
    };

    PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      Toast.show('Please check your phone for the verification code.', context,
          duration: 2, gravity: Toast.BOTTOM);
      setState(() {
        _verificationId = verificationId;
      });
      print(_verificationId);
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => OtpVerification(
      //       mobilenum: mobno,
      //       user_name: uname,
      //       device_id: device_id,
      //       uId: uId,
      //       verificationId: _verificationId,
      //     ),
      //   ),
      // );
    };

    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      Toast.show('verification code:' + verificationId, context,
          duration: 2, gravity: Toast.BOTTOM);

      _verificationId = verificationId;
      print(_verificationId);
    };

    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: contact,
          timeout: const Duration(seconds: 60),
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    } catch (e) {
      // Toast.show('Failed to Verify Phone Number: ${e}', context,
      //     duration: 2, gravity: Toast.BOTTOM);
      Toast.show('Sending Otp...', context, duration: 3, gravity: Toast.BOTTOM);
    }
  }

  void signInWithPhoneNumber(String enteredOtp) async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: smsOTP,
      );
      print('OTP SUCCESSSSS@@@@@@@@@@@@@@@@@@@');
      final User user = (await _auth.signInWithCredential(credential)).user;
      Toast.show("Successfully signed", context,
          duration: 2, gravity: Toast.BOTTOM);
      print("Successfully signed in UID: ${user.uid}");
      loginSuccess();
    } catch (e) {
      print('OTP INCORRECTT@@@@@@@@@@@@@@@@@@@@@@');
      Toast.show("Failed to sign in: " + e.toString(), context,
          duration: 2, gravity: Toast.BOTTOM);
    }
  }

  loginSuccess() async {
    setAsLoggedIn(true);
    Navigator.pushReplacementNamed(context, '/homeScreen');
    await UserSimplePreferences.setPhone(fphone);
  }

  //Method for handle the errors
  void handleError(FirebaseAuthException error) {
    switch (error.code) {
      case 'ERROR_INVALID_VERIFICATION_CODE':
        FocusScope.of(context).requestFocus(FocusNode());
        setState(() {
          errorMessage = 'Invalid Code';
        });
        showAlertDialog(context, 'Invalid Code');
        break;
      default:
        showAlertDialog(context, error.message);
        break;
    }
  }

  //Basic alert dialogue for alert errors and confirmations
  void showAlertDialog(BuildContext context, String message) {
    // set up the AlertDialog
    final CupertinoAlertDialog alert = CupertinoAlertDialog(
      title: const Text('Error'),
      content: Text('\n$message'),
      actions: <Widget>[
        CupertinoDialogAction(
          isDefaultAction: true,
          child: const Text('Ok'),
          onPressed: () {
            Navigator.of(context).pop();
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
}
