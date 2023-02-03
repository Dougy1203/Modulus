import 'package:flutter/material.dart';
import 'package:flutter_youtube_view/flutter_youtube_view.dart';
import 'package:modulus/custom_widgets/YoutubeDefaultWidget.dart';
import 'package:modulus/pages/modulus.dart';
import 'package:modulus/pages/page_user_new.dart';
import '../constants/constants.dart';
import 'package:modulus/custom_widgets/main_image.dart';
import 'package:modulus/custom_widgets/my_text_field.dart';
import 'package:http/http.dart' as http;

import '../custom_widgets/module.dart';
import '../custom_widgets/pdf_render.dart';
import 'home.dart';

class Modulus extends StatefulWidget {
  const Modulus({super.key, required this.corporateController, required this.userController, required this.passController, required this.mods});
  final List<String> mods;
  final TextEditingController corporateController;
  final TextEditingController userController;
  final TextEditingController passController;
  @override
  State<Modulus> createState() => _ModulusState();
}
//PDFViewer(uri: 'https://www.ece.uvic.ca/~itraore/elec567-13/notes/dist-03-4.pdf')
class _ModulusState extends State<Modulus> {
  List<Widget> mods(){
    List<Widget> widgets = [];
    for(String s in widget.mods)
      {
        widgets.add(Module(modName: s));
      }
    return widgets;
  }
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
          title: Text(widget.corporateController.text),
          titleSpacing: 2.0,
          centerTitle: true,
        ),
        backgroundColor: kBackgroundColor,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox( width: double.infinity),
              Text(
                'Welcome ${widget.userController.text}',
                style: TextStyle(
                  letterSpacing: 2.0,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor,
                ),
              ),
              const PDFNetwork(uri: 'https://www.ece.uvic.ca/~itraore/elec567-13/notes/dist-03-4.pdf', title: 'Network PDF'),
              const PDFAsset(uri: 'files/275.pdf', title: 'Asset PDF'),
              // const YoutubeDefaultWidget(videoId:'FjHGZj2IjBk'),
              const YoutubeDefaultWidget(videoId:'OeHLHNKQCXA'),
              Column(
                children: mods(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
