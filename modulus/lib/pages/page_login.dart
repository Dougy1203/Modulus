import 'package:flutter/material.dart';
import 'package:modulus/pages/modulus.dart';
import 'package:modulus/pages/page_corp_new.dart';
import 'package:modulus/pages/page_corp_signin.dart';
import 'package:modulus/pages/page_user_new.dart';
import '../constants/constants.dart';
import 'package:modulus/custom_widgets/main_image.dart';
import 'package:modulus/custom_widgets/my_text_field.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final corporateController = TextEditingController();
  final userController = TextEditingController();
  final passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: const Text('LOGIN'),
          titleSpacing: 2.0,
          centerTitle: true,
        ),
        backgroundColor: kBackgroundColor,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const MainImage('images/logo.png', 15.0, 200.0, 200.0),
              MyTextField(
                text: 'Corporate Name',
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    child: Wrap(children: [
                      Container(
                        width: 90.0,
                        height: 30.0,
                        color: kPrimaryColor,
                        child: const Center(child: Text('Sign In')),
                      ),
                    ]),
                    onPressed: () async {
                      var containsMap = <String, dynamic>{};
                      containsMap['corpName'] = corporateController.text;
                      containsMap['userName'] = userController.text;
                      var corpUsers = await http.post(Uri.parse('http://10.0.2.2:8888/corporationmicroservice/corp/containsUser'), body: containsMap);
                      print(corpUsers.body);
                      var map = <String, dynamic>{};
                      map['userName'] = userController.text;
                      map['userPassword'] = passController.text;
                      final response = await http.post(
                          Uri.parse('http://10.0.2.2:8888/usermicroservice/user/validate'),
                          body: map);
                      final mods = await apiGet(
                          'http://10.0.2.2:8888/corporationmicroservice/corp/getMods/${corporateController.text}');
                      // print(mods);
                      // print('corpUsers: ${corpUsers.statusCode}');
                      // print('response: ${response.statusCode}');
                      if (corpUsers.statusCode == 200 && response.statusCode == 200){
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Modulus(
                                    corporateController: corporateController,
                                    userController: userController,
                                    passController: passController,
                                    mods: mods)));
                      }
                    },
                  ),
                  MaterialButton(
                    child: Wrap(children: [
                      Container(
                        width: 90.0,
                        height: 30.0,
                        color: kPrimaryColor,
                        child: const Center(child: Text('Sign Up')),
                      ),
                    ]),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUp()));
                    },
                  ),
                ],
              ),
              const SizedBox(
                width: double.infinity,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  MaterialButton(
                    child: Wrap(children: [
                      Container(
                        width: 90.0,
                        height: 30.0,
                        color: kPrimaryColor,
                        child: const Center(child: Text('New Corp')),
                      ),
                    ]),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NewCorp()));
                    },
                  ),
                  MaterialButton(
                    child: Wrap(children: [
                      Container(
                        width: 90.0,
                        height: 30.0,
                        color: kPrimaryColor,
                        child: const Center(child: Text('Corp Sign In')),
                      ),
                    ]),
                    onPressed: () async {
                      var map = <String, dynamic>{};
                      map['corpName'] = corporateController.text;
                      map['corpPassword'] = passController.text;
                      final response = await http.post(
                          Uri.parse('http://10.0.2.2:8888/corporationmicroservice/corp/validate'),
                          body: map);
                      if (response.statusCode == 200) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CorpSignIn(
                                    corpName: corporateController.text)));
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
