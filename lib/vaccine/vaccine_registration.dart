// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:ktrack19/vaccine/regis_sucsses.dart';
//
// class VaccineRegister extends StatefulWidget {
//   @override
//   _VaccineRegisterState createState() => _VaccineRegisterState();
// }
//
// class _VaccineRegisterState extends State<VaccineRegister> {
//
//   TextEditingController nameField = new TextEditingController();
//   TextEditingController mailField = new TextEditingController();
//   TextEditingController phoneField = new TextEditingController();
//   TextEditingController pincodeField = new TextEditingController();
//   TextEditingController aadhaarField = new TextEditingController();
//   TextEditingController ageField = new TextEditingController();
//   String name;
//   String _email;
//   String _phoneNumber;
//   String _pincode;
//   String _aadhaar;
//   String _age;
//
//   final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
//
//   Widget _buildName() {
//     return TextFormField(
//       controller: nameField,
//       decoration: InputDecoration(labelText: 'Name'),
//       validator: (String value) {
//         if (value.isEmpty) {
//           return 'Name is Required';
//         }
//       },
//       onSaved: (String value) {
//         name = value;
//       },
//     );
//   }
//
//   Widget _buildEmail() {
//     return TextFormField(
//       controller: mailField,
//       decoration: InputDecoration(labelText: 'Email'),
//       keyboardType: TextInputType.emailAddress,
//       validator: (String value) {
//         if (value.isEmpty) {
//           return 'Email Id is Required';
//         }
//         if (!RegExp(
//                 r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
//             .hasMatch(value)) {
//           return 'Please enter A valid Email Address';
//         }
//         return null;
//       },
//       onSaved: (String value) {
//         _email = value;
//       },
//     );
//   }
//
//   Widget _buildPhonenumber() {
//     return TextFormField(
//       controller: phoneField,
//       decoration: InputDecoration(labelText: 'Phone Number'),
//       keyboardType: TextInputType.phone,
//       maxLength: 10,
//       validator: (String value) {
//         if (value.length < 6) {
//           return 'Please Enter 10 Digit Phone Number';
//         } else if (value.length == null) {
//           return 'Phone Number is Required';
//         }
//       },
//       onSaved: (String value) {
//         _phoneNumber = value;
//       },
//     );
//   }
//
//   Widget _buildNPincode() {
//     return TextFormField(
//       controller: pincodeField,
//       decoration: InputDecoration(labelText: 'Pincode'),
//       maxLength: 6,
//       keyboardType: TextInputType.phone,
//       validator: (String value) {
//         if (value.length < 6) {
//           return 'Please Enter 6 Digit Pincode';
//         } else if (value.length == null) {
//           return 'Pincode is Required';
//         }
//       },
//       onSaved: (String value) {
//         _pincode = value;
//       },
//     );
//   }
//
//   Widget _buildaadhaar() {
//     return TextFormField(
//       controller: aadhaarField,
//       decoration: InputDecoration(labelText: 'Aadhaar Number'),
//       maxLength: 14,
//       keyboardType: TextInputType.phone,
//       validator: (String value) {
//         if (value.length < 14) {
//           return 'Please Enter 14 Digit Aadhaar Number';
//         } else if (value.length == null) {
//           return 'Aadhaar Number is Required';
//         }
//       },
//       onSaved: (String value) {
//         _aadhaar = value;
//       },
//     );
//   }
//
//   Widget _buildAge() {
//     return TextFormField(
//       controller: ageField,
//       decoration: InputDecoration(labelText: 'Age'),
//       keyboardType: TextInputType.number,
//       validator: (String value) {
//         int age = int.tryParse(value);
//         if (age == null || age < 18) {
//           return 'Age must be above 18';
//         }
//       },
//       onSaved: (String value) {
//         _age = value;
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.teal[800],
//         title: Center(child: Text('Vaccine Registeration')),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back_ios_outlined,
//               color: Colors.white, size: 20),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: Container(
//         margin: EdgeInsets.fromLTRB(24, 70, 24, 0),
//         child: Form(
//           key: _formkey,
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 _buildName(),
//                 _buildEmail(),
//                 _buildPhonenumber(),
//                 _buildaadhaar(),
//                 _buildNPincode(),
//                 _buildAge(),
//                 SizedBox(
//                   height: 100,
//                 ),
//                 TextButton(
//                   child: Text(
//                     '  Register  ',
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.w500,
//                         fontSize: 17),
//                   ),
//                   style: TextButton.styleFrom(
//                     backgroundColor: Colors.black,
//                     primary: Colors.black, //
//                     shape: RoundedRectangleBorder(
//                       borderRadius: new BorderRadius.circular(12.0),
//                       side: BorderSide(color: Colors.black),
//                     ), // foreground
//                   ),
//                   onPressed: () {
//                     if (!_formkey.currentState.validate()) {
//                       return;
//                     }
//                     _formkey.currentState.save();
//                     print('Name:$name');
//                     print('Email: $_email');
//                     print('Phone: $_phoneNumber');
//                     print('Pincode: $_pincode');
//                     print('aadhaar: $_aadhaar');
//                     print('Age: $_age');
//
//                     Map<String, dynamic> data = {
//                       "Name": nameField.text,
//                       "Email": mailField.text,
//                       "Phone": phoneField.text,
//                       "Pincode": pincodeField.text,
//                       "aadhaar": aadhaarField.text,
//                       "Age": ageField.text,
//                     };
//                     print('Form Submitted');
//                     FirebaseFirestore.instance
//                         .collection("Registration Form")
//                         .add(data);
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => RegisSuccess()));
//                     print('Navigated');
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
