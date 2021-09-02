import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:ktracker/initialPages/home.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ktracker/screens/utils/user_simple_prefereences.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile Page',
      home: EditProfilePage(),
    );
  }
}

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController nameField = new TextEditingController();
  TextEditingController mailField = new TextEditingController();
  TextEditingController phoneField = new TextEditingController();
  TextEditingController locationField = new TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  String fname = '';

  var fmail = '';

  var fphone = '';

  var flocation = '';

  var fnickname = '';

  @override
  void initState() {
    super.initState();
    fname = UserSimplePreferences.getUsername() ?? '';
    fmail = UserSimplePreferences.getMail() ?? '';
    fphone = UserSimplePreferences.getPhone() ?? '';
    flocation = UserSimplePreferences.getLocation() ?? '';
    fnickname = UserSimplePreferences.getNickname() ?? '';
  }

  Widget _buildName() {
    return Column(
      children: [
        TextFormField(
          initialValue: fname,
          onChanged: (fname) => setState(() => this.fname = fname),
          validator: (String value) {
            if (value.isEmpty) {
              return 'Name is Required';
            }
          },
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: 'Full Name',
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: 'Enter Name',
            hintStyle: TextStyle(
                fontWeight: FontWeight.w300, fontSize: 16, color: Colors.black),
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget _buildNickName() {
    return Column(
      children: [
        TextFormField(
          initialValue: fnickname,
          onChanged: (fnickname) => setState(() => this.fnickname = fnickname),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: 'Nick Name',
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: 'Nick Name',
            hintStyle: TextStyle(
                fontWeight: FontWeight.w300, fontSize: 16, color: Colors.black),
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget _buildEmail() {
    return Column(
      children: [
        TextFormField(
          initialValue: fmail,
          onChanged: (fmail) => setState(() => this.fmail = fmail),
          keyboardType: TextInputType.emailAddress,
          validator: (String value) {
            if (value.isEmpty) {
              return 'Email Id is Required';
            }
            if (!RegExp(
                    r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                .hasMatch(value)) {
              return 'Please enter A valid Email Address';
            }
            return null;
          },
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: 'Email',
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: 'Alexa@example.com',
            hintStyle: TextStyle(
                fontWeight: FontWeight.w300, fontSize: 16, color: Colors.black),
          ),
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }

  Widget _buildPhone() {
    return Column(
      children: [
        TextFormField(
          initialValue: fphone,
          onChanged: (fphone) => setState(() => this.fphone = fphone),
          keyboardType: TextInputType.phone,
          maxLength: 10,
          validator: (String value) {
            if (value.length < 10) {
              return 'Please Enter 10 Digit Phone Number';
            } else if (value.length == null) {
              return 'Phone Number is Required';
            }
          },
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: 'Phone Number',
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: 'x x x x x',
            hintStyle: TextStyle(
                fontWeight: FontWeight.w300, fontSize: 16, color: Colors.black),
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget _buildLocation() {
    return Column(
      children: [
        TextFormField(
          initialValue: flocation,
          onChanged: (flocation) => setState(() => this.flocation = flocation),
          validator: (String value) {
            if (value.isEmpty) {
              return 'Location is Required';
            }
          },
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: 'Location',
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: 'Thiruvananthapuram',
            hintStyle: TextStyle(
                fontWeight: FontWeight.w300, fontSize: 16, color: Colors.black),
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_outlined,
            color: Colors.teal[600],
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Text(
                "Edit Profile",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
              ),
              imageProfile(),

              Form(
                key: _formkey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 28,
                    ),
                    _buildName(),
                    _buildNickName(),
                    _buildEmail(),
                    _buildLocation(),
                  ],
                ),
              ),

              //

              Padding(
                padding: const EdgeInsets.only(top: 80),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // ignore: deprecated_member_use
                    OutlineButton(
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()));
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2.2,
                            color: Colors.black),
                      ),
                    ),
                    // ignore: deprecated_member_use
                    RaisedButton(
                      onPressed: () async {
                        if (!_formkey.currentState.validate()) {
                          Toast.show("Please Complete Profile", context,
                              duration: 2, gravity: Toast.BOTTOM);
                          print('Name:Please Complete Profile');
                          print('Email: Please Complete Profile');
                          print('Phone:Please Complete Profile ');
                          print('Location: Please Complete Profile');
                          print('Mail: Please Complete Profile');
                        } else {
                          Toast.show("Profile Updated", context,
                              duration: 2, gravity: Toast.BOTTOM);
                          await UserSimplePreferences.setUserName(fname);
                          await UserSimplePreferences.setMail(fmail);
                          await UserSimplePreferences.setNickname(fnickname);
                          await UserSimplePreferences.setPhone(fphone);
                          await UserSimplePreferences.setLocation(flocation);
                          print('Name:$fname');
                          print('Email: $fnickname');
                          print('Phone: $fphone');
                          print('Location: $flocation');
                          print('Mail: $fmail');
                        }
                      },
                      color: Colors.teal[600],
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18)),
                      child: Text(
                        "SAVE",
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2.2,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget imageProfile() {
    return Center(
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  context: context, builder: ((builder) => bottomSheet()));
            },
            child: Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                border: Border.all(width: 4, color: Colors.white),
                boxShadow: [
                  BoxShadow(
                      spreadRadius: 2,
                      blurRadius: 10,
                      color: Colors.black.withOpacity(0.10),
                      offset: Offset(0, 10))
                ],
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: _imageFile == null
                      ? AssetImage('assets/images/avatar.png')
                      : FileImage(File(_imageFile.path)),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 4, color: Colors.white),
                color: Colors.teal[600],
              ),
              child: IconButton(
                  icon: Icon(
                    Icons.camera_alt_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: ((builder) => bottomSheet()));
                  }),
            ),
          )
        ],
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          Text(
            "Choose Profile Photo",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ignore: deprecated_member_use
              FlatButton.icon(
                icon: Icon(Icons.camera),
                onPressed: () {
                  takePhoto(ImageSource.camera);
                },
                label: Text("Camera"),
              ),
              // ignore: deprecated_member_use
              FlatButton.icon(
                icon: Icon(Icons.image),
                onPressed: () {
                  takePhoto(ImageSource.gallery);
                },
                label: Text("Gallery"),
              )
            ],
          )
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(
      source: source,
    );
    setState(() {
      _imageFile = pickedFile;
    });
  }

//   TextField buildTextField(String labelText, String placeholder, String Controller) {
//     return
//       TextField(
//         controller: nameF,
//       decoration: InputDecoration(
//         contentPadding: EdgeInsets.only(bottom: 3),
//         labelText: labelText,
//         floatingLabelBehavior: FloatingLabelBehavior.always,
//         hintText: placeholder,
//         hintStyle: TextStyle(
//             fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
//       ),
//     );
//   }
// }
}
