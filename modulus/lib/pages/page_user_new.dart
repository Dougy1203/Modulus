import 'package:flutter/material.dart';
import 'package:modulus/pages/modulus.dart';
import '../constants/constants.dart';
import 'package:modulus/custom_widgets/main_image.dart';
import 'package:modulus/custom_widgets/my_text_field.dart';
import 'package:http/http.dart' as http;

import 'home.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final corporateController = TextEditingController();
  final userController = TextEditingController();
  final passController = TextEditingController();
  final emailController = TextEditingController();
  final fNameController = TextEditingController();
  final lNameController = TextEditingController();
  int responseHeight = 0;
  String responseText = '';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: const Text('SIGN UP'),
          titleSpacing: 2.0,
          centerTitle: true,
        ),
        backgroundColor: kBackgroundColor,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              MaterialButton(
                padding: const EdgeInsets.all(0.0),
                onPressed: () {
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (context) => Home()));
                },
                child: const MainImage('images/logo.png', 15.0, 200.0, 200.0),
              ),
              MyTextField(
                text: 'Corporate ID',
                icon: Icons.corporate_fare,
                obscured: false,
                myController: corporateController,
              ),
              MyTextField(
                text: 'UserName',
                icon: Icons.person,
                obscured: false,
                myController: userController,
              ),
              MyTextField(
                text: 'Password',
                icon: Icons.password,
                obscured: true,
                myController: passController,
              ),
              MyTextField(
                text: 'Email',
                icon: Icons.alternate_email,
                obscured: false,
                myController: emailController,
              ),
              MyTextField(
                text: 'First Name',
                icon: Icons.drive_file_rename_outline,
                obscured: false,
                myController: fNameController,
              ),
              MyTextField(
                text: 'Last Name',
                icon: Icons.drive_file_rename_outline,
                obscured: false,
                myController: lNameController,
              ),
              MaterialButton(
                child: Wrap(children: [
                  Container(
                    width: 110.0,
                    height: 40.0,
                    color: kPrimaryColor,
                    child: const Center(
                      child: Text(
                        'Create User',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ]),
                onPressed: () async {
                  Future<String> fetchAlbum() async {
                    var map = <String, dynamic>{};
                    map['_userName'] = userController.text;
                    map['_userPassword'] = passController.text;
                    map['_userEmail'] = emailController.text;
                    map['_firstName'] = fNameController.text;
                    map['_lastName'] = lNameController.text;
                    map['_userRole'] = '';
                    final response = await http.post(
                        Uri.parse('http://10.0.2.2:8888/usermicroservice/user/addUser'),
                        body: map);
                    print(response.statusCode);
                    if (response.statusCode == 200) {
                      var corp = <String, dynamic>{};
                      corp['corpName'] = corporateController.text;
                      corp['request'] = userController.text;
                      await http.post(
                        Uri.parse('http://10.0.2.2:8888/corporationmicroservice/corp/addRequest'),
                        body: corp);
                      return "UserCreated";
                    }
                    return "Failed";
                  }
                  final res = await fetchAlbum();
                  print(res);
                  if (res == 'UserCreated') {

                  }

                  // Navigator.popAndPushNamed(
                  //     context,
                  //     '/signedin'
                  // );
                },
              ),
              const SizedBox(
                width: double.infinity,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
