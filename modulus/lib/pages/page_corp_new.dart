import 'package:flutter/material.dart';
import 'package:modulus/pages/modulus.dart';
import 'package:modulus/pages/page_user_new.dart';
import '../constants/constants.dart';
import 'package:modulus/custom_widgets/main_image.dart';
import 'package:modulus/custom_widgets/my_text_field.dart';
import 'package:http/http.dart' as http;

import 'home.dart';

class NewCorp extends StatefulWidget {
  const NewCorp({super.key});
  @override
  State<NewCorp> createState() => _NewCorpState();
}

class _NewCorpState extends State<NewCorp> {
  final corporateController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          leading: MaterialButton(
            padding: const EdgeInsets.all(0.0),
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
            },
            child: const Image(
              image: AssetImage('images/logo.png'),
            ),
          ),
          title: const Text('NEW CORP'),
          titleSpacing: 2.0,
          centerTitle: true,
        ),
        backgroundColor: kBackgroundColor,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              MaterialButton(
                child: const MainImage('images/logo.png', 15.0, 200.0, 200.0),
                onPressed: () {
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (context) => Home()));
                },
              ),
              MyTextField(
                text: 'Corporate Name',
                icon: Icons.corporate_fare,
                obscured: false,
                myController: corporateController,
              ),
              MyTextField(
                text: 'Corporate Email',
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
                color: kPrimaryColor,
                child: Wrap(children: const [
                  Center(child: Text('Create Corporation')),
                ]),
                onPressed: () async {
                  Future<String> fetchAlbum() async {
                    var map = <String, dynamic>{};
                    map['_name'] = corporateController.text;
                    map['_password'] = passController.text;
                    map['_email'] = emailController.text;
                    final response = await http.post(
                        Uri.parse('http://10.0.2.2:8888/corporationmicroservice/corp/newCorp'),
                        body: map);
                    print(response.statusCode);
                    if (response.statusCode == 200) {
                      return "Ok";
                    }
                    return "Failed";
                  }

                  final res = await fetchAlbum();
                  print(res);
                  if (res == 'Ok') {
                  }
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
