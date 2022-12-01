import 'package:flutter/material.dart';
import 'package:modulus/constants/constants.dart';
import 'package:modulus/pages/page_login.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: double.infinity,
            ),
            MaterialButton(
              child: const Image(
                image: AssetImage('images/logo.png'),
              ),
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()));
              },
            ),
            Text(
              'Modulus',
              style: TextStyle(
                fontSize: 50.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 5.0,
                color: kPrimaryColor,

              ),
            ),
          ],
        ),
      ),
    );
  }
}
