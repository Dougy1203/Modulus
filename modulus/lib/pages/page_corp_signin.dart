import 'package:flutter/material.dart';
import 'package:modulus/pages/modulus.dart';
import 'package:modulus/pages/page_user_new.dart';
import '../constants/constants.dart';
import 'package:modulus/custom_widgets/main_image.dart';
import 'package:modulus/custom_widgets/my_text_field.dart';
import 'package:http/http.dart' as http;

import 'home.dart';

class CorpSignIn extends StatefulWidget {
  const CorpSignIn({super.key, required this.corpName});
  final String corpName;
  @override
  State<CorpSignIn> createState() => _CorpSignInState();
}

class _CorpSignInState extends State<CorpSignIn> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final pass2Controller = TextEditingController();
  final modNameController = TextEditingController();
  final fileController = TextEditingController();
  final fileTitleController = TextEditingController();
  final roleNameController = TextEditingController();
  final modName2Controller = TextEditingController();
  final userController = TextEditingController();
  final roleController = TextEditingController();

  var nameHeight = 0.0;
  var emailHeight = 0.0;
  var passHeight = 0.0;
  var modHeight = 0.0;
  var fileHeight = 0.0;
  var m2mHeight = 0.0;
  var userHeight = 0.0;
  var roleHeight = 0.0;

  var nameIcon = Icons.arrow_downward;
  var emailIcon = Icons.arrow_downward;
  var passIcon = Icons.arrow_downward;
  var modIcon = Icons.arrow_downward;
  var fileIcon = Icons.arrow_downward;
  var m2mIcon = Icons.arrow_downward;
  var userIcon = Icons.arrow_downward;
  var roleIcon = Icons.arrow_downward;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          // leading: MaterialButton(
          //   padding: const EdgeInsets.all(0.0),
          //   onPressed: () {
          //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
          //   },
          //   child: const Image(
          //     image: AssetImage('images/logo.png'),
          //   ),
          // ),
          title: Text(widget.corpName),
          titleSpacing: 2.0,
          centerTitle: true,
        ),
        backgroundColor: kBackgroundColor,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //Logo
              MaterialButton(
                child: const MainImage('images/logo.png', 15.0, 200.0, 200.0),
                onPressed: () {
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (context) => Home()));
                },
              ),
              //Update Name
              MaterialButton(
                onPressed: () {
                  setState(() {
                    if (nameHeight == 0.0) {
                      nameHeight = 300.0;
                      nameIcon = Icons.arrow_upward;
                    } else {
                      nameHeight = 0.0;
                      nameIcon = Icons.arrow_downward;
                    }
                  });
                },
                child: SizedBox(
                  width: double.infinity,
                  height: 40.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Update Name',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.0,
                          color: kPrimaryColor,
                        ),
                      ),
                      Icon(nameIcon, size: 40.0, color: kPrimaryColor),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: nameHeight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    MyTextField(
                      text: 'New Name',
                      icon: Icons.drive_file_rename_outline,
                      obscured: false,
                      myController: nameController,
                    ),
                    MyTextField(
                      text: 'Corporate Password',
                      icon: Icons.password,
                      obscured: true,
                      myController: passController,
                    ),
                    MaterialButton(
                      child: Wrap(children: [
                        Container(
                          width: 90.0,
                          height: 30.0,
                          color: kPrimaryColor,
                          child: const Center(child: Text('Submit')),
                        ),
                      ]),
                      onPressed: () async {
                        Map map = <String, dynamic>{};
                        map['corpName'] = widget.corpName;
                        map['corpPassword'] = passController.text;
                        map['newName'] = nameController.text;
                        var res = await http.post(
                            Uri.parse(
                                'http://10.0.2.2:8888/corporationmicroservice/corp/updateCorpName'),
                            body: map);
                        print(res.body);
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => Home()),
                            (route) => false);
                      },
                    ),
                  ],
                ),
              ),
              //Update Email
              MaterialButton(
                onPressed: () {
                  setState(() {
                    if (emailHeight == 0.0) {
                      emailHeight = 300.0;
                      emailIcon = Icons.arrow_upward;
                    } else {
                      emailHeight = 0.0;
                      emailIcon = Icons.arrow_downward;
                    }
                  });
                },
                child: SizedBox(
                  width: double.infinity,
                  height: 40.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Update Email',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.0,
                          color: kPrimaryColor,
                        ),
                      ),
                      Icon(emailIcon, size: 40.0, color: kPrimaryColor),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: emailHeight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    MyTextField(
                      text: 'New Email',
                      icon: Icons.alternate_email_outlined,
                      obscured: false,
                      myController: emailController,
                    ),
                    MyTextField(
                      text: 'Corporate Password',
                      icon: Icons.password,
                      obscured: true,
                      myController: passController,
                    ),
                    MaterialButton(
                      child: Wrap(children: [
                        Container(
                          width: 90.0,
                          height: 30.0,
                          color: kPrimaryColor,
                          child: const Center(child: Text('Submit')),
                        ),
                      ]),
                      onPressed: () async {
                        Map map = <String, dynamic>{};
                        map['corpName'] = widget.corpName;
                        map['corpPassword'] = passController.text;
                        map['newEmail'] = emailController.text;
                        var res = await http.post(
                            Uri.parse(
                                'http://10.0.2.2:8888/corporationmicroservice/corp/updateCorpEmail'),
                            body: map);
                        print(res.body);
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => Home()),
                            (route) => false);
                      },
                    ),
                  ],
                ),
              ),
              //Update Password
              MaterialButton(
                onPressed: () {
                  setState(() {
                    if (passHeight == 0.0) {
                      passHeight = 300.0;
                      passIcon = Icons.arrow_upward;
                    } else {
                      passHeight = 0.0;
                      passIcon = Icons.arrow_downward;
                    }
                  });
                },
                child: SizedBox(
                  width: double.infinity,
                  height: 40.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Update Password',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.0,
                          color: kPrimaryColor,
                        ),
                      ),
                      Icon(passIcon, size: 40.0, color: kPrimaryColor),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: passHeight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    MyTextField(
                      text: 'New Password',
                      icon: Icons.password_rounded,
                      obscured: false,
                      myController: pass2Controller,
                    ),
                    MyTextField(
                      text: 'Corporate Password',
                      icon: Icons.password_rounded,
                      obscured: true,
                      myController: passController,
                    ),
                    MaterialButton(
                      child: Wrap(children: [
                        Container(
                          width: 90.0,
                          height: 30.0,
                          color: kPrimaryColor,
                          child: const Center(child: Text('Submit')),
                        ),
                      ]),
                      onPressed: () async {
                        Map map = <String, dynamic>{};
                        map['corpName'] = widget.corpName;
                        map['corpPassword'] = passController.text;
                        map['newPassword'] = pass2Controller.text;
                        var res = await http.post(
                            Uri.parse(
                                'http://10.0.2.2:8888/corporationmicroservice/corp/updateCorpPassword'),
                            body: map);
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => Home()),
                            (route) => false);
                      },
                    ),
                  ],
                ),
              ),
              //Add Mod
              MaterialButton(
                onPressed: () {
                  setState(() {
                    if (modHeight == 0.0) {
                      modHeight = 300.0;
                      modIcon = Icons.arrow_upward;
                    } else {
                      modHeight = 0.0;
                      modIcon = Icons.arrow_downward;
                    }
                  });
                },
                child: SizedBox(
                  width: double.infinity,
                  height: 40.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Add Module',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.0,
                          color: kPrimaryColor,
                        ),
                      ),
                      Icon(modIcon, size: 40.0, color: kPrimaryColor),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: modHeight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    MyTextField(
                      text: 'Module Name',
                      icon: Icons.drive_file_rename_outline,
                      obscured: false,
                      myController: modNameController,
                    ),
                    MyTextField(
                      text: 'Corporate Password',
                      icon: Icons.password_rounded,
                      obscured: true,
                      myController: passController,
                    ),
                    MaterialButton(
                      child: Wrap(children: [
                        Container(
                          width: 90.0,
                          height: 30.0,
                          color: kPrimaryColor,
                          child: const Center(child: Text('Submit')),
                        ),
                      ]),
                      onPressed: () async {
                        Map map = <String, dynamic>{};
                        map['corpName'] = widget.corpName;
                        map['corpPassword'] = passController.text;
                        map['modName'] = modNameController.text;
                        Map addMap = <String, dynamic>{};
                        addMap['modName'] = modNameController.text;
                        var res = await http.post(
                            Uri.parse(
                                'http://10.0.2.2:8888/modulemicroservice/mod/createMod'),
                            body: addMap);
                        var res2 = await http.post(
                            Uri.parse(
                                'http://10.0.2.2:8888/corporationmicroservice/corp/newMod'),
                            body: map);
                        print(res.statusCode);
                        if (res.statusCode == 200) {
                          print('Module Created');
                        }
                        if (res2.statusCode == 200) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => Home()),
                              (route) => false);
                        }
                      },
                    ),
                  ],
                ),
              ),
              //Add File to Mod
              MaterialButton(
                onPressed: () {
                  setState(() {
                    if (fileHeight == 0.0) {
                      fileHeight = 400.0;
                      fileIcon = Icons.arrow_upward;
                    } else {
                      fileHeight = 0.0;
                      fileIcon = Icons.arrow_downward;
                    }
                  });
                },
                child: SizedBox(
                  width: double.infinity,
                  height: 40.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Add Module File',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.0,
                          color: kPrimaryColor,
                        ),
                      ),
                      Icon(fileIcon, size: 40.0, color: kPrimaryColor),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: fileHeight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    MyTextField(
                      text: 'Module Name',
                      icon: Icons.drive_file_rename_outline,
                      obscured: false,
                      myController: modNameController,
                    ),
                    MyTextField(
                      text: 'File Title',
                      icon: Icons.drive_file_rename_outline,
                      obscured: false,
                      myController: fileTitleController,
                    ),
                    MyTextField(
                      text: 'File Path',
                      icon: Icons.drive_file_rename_outline,
                      obscured: false,
                      myController: fileController,
                    ),
                    MaterialButton(
                      child: Wrap(children: [
                        Container(
                          width: 90.0,
                          height: 30.0,
                          color: kPrimaryColor,
                          child: const Center(child: Text('Submit')),
                        ),
                      ]),
                      onPressed: () async {
                        Map map = <String, dynamic>{};
                        map['modName'] = modNameController.text;
                        map['entryKey'] = fileTitleController.text;
                        map['entryValue'] = fileController.text;
                        var res = await http.post(
                            Uri.parse(
                                'http://10.0.2.2:8888/modulemicroservice/mod/addFile'),
                            body: map);
                        if (res.statusCode == 200) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => Home()),
                              (route) => false);
                        }
                      },
                    ),
                  ],
                ),
              ),
              //Add Mod to Mod
              MaterialButton(
                onPressed: () {
                  setState(() {
                    if (m2mHeight == 0.0) {
                      m2mHeight = 400.0;
                      m2mIcon = Icons.arrow_upward;
                    } else {
                      m2mHeight = 0.0;
                      m2mIcon = Icons.arrow_downward;
                    }
                  });
                },
                child: SizedBox(
                  width: double.infinity,
                  height: 40.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Add Child Module',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.0,
                          color: kPrimaryColor,
                        ),
                      ),
                      Icon(m2mIcon, size: 40.0, color: kPrimaryColor),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: m2mHeight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    MyTextField(
                      text: 'Parent Module Name',
                      icon: Icons.drive_file_rename_outline,
                      obscured: false,
                      myController: modNameController,
                    ),
                    MyTextField(
                      text: 'Child Module Name',
                      icon: Icons.drive_file_rename_outline,
                      obscured: false,
                      myController: modName2Controller,
                    ),
                    MaterialButton(
                      child: Wrap(children: [
                        Container(
                          width: 90.0,
                          height: 30.0,
                          color: kPrimaryColor,
                          child: const Center(child: Text('Submit')),
                        ),
                      ]),
                      onPressed: () async {
                        Map map = <String, dynamic>{};
                        map['modName'] = modNameController.text;
                        map['entryName'] = modName2Controller.text;
                        var res = await http.post(
                            Uri.parse(
                                'http://10.0.2.2:8888/modulemicroservice/mod/addM2M'),
                            body: map);
                        if (res.statusCode == 200) {
                          Map map2 = <String, dynamic>{};
                          map2['corpName'] = widget.corpName;
                          map2['modName'] = modName2Controller.text;
                          var res2 = await http.post(
                              Uri.parse(
                                  'http://10.0.2.2:8888/corporationmicroservice/corp/removeMod'),
                              body: map2);
                          if (res2.statusCode == 200) {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (context) => Home()),
                                (route) => false);
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
              //Add User
              MaterialButton(
                onPressed: () {
                  setState(() {
                    if (userHeight == 0.0) {
                      userHeight = 400.0;
                      userIcon = Icons.arrow_upward;
                    } else {
                      userHeight = 0.0;
                      userIcon = Icons.arrow_downward;
                    }
                  });
                },
                child: SizedBox(
                  width: double.infinity,
                  height: 40.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Add User',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.0,
                          color: kPrimaryColor,
                        ),
                      ),
                      Icon(userIcon, size: 40.0, color: kPrimaryColor),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: userHeight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    MyTextField(
                      text: 'User Name',
                      icon: Icons.drive_file_rename_outline,
                      obscured: false,
                      myController: userController,
                    ),
                    MyTextField(
                      text: 'Child Module Name',
                      icon: Icons.drive_file_rename_outline,
                      obscured: false,
                      myController: modName2Controller,
                    ),
                    MyTextField(
                      text: 'Corporate Password',
                      icon: Icons.password_rounded,
                      obscured: true,
                      myController: passController,
                    ),
                    MaterialButton(
                      child: Wrap(children: [
                        Container(
                          width: 90.0,
                          height: 30.0,
                          color: kPrimaryColor,
                          child: const Center(child: Text('Submit')),
                        ),
                      ]),
                      onPressed: () {},
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
