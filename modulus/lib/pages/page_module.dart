import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../custom_widgets/module.dart';
import '../custom_widgets/pdf_render.dart';
import 'home.dart';

class ModulePage extends StatefulWidget {
  const ModulePage({super.key, required this.modName, required this.files, required this.modules, required this.roles});
  final String modName;
  final Map<String,String> files;
  final List<String> modules;
  final List<String> roles;
  @override
  State<ModulePage> createState() => _ModulePageState();
}

class _ModulePageState extends State<ModulePage> {
  List<Widget> files() {
    List<Widget> widgets = [];
    try {
      widget.files.forEach((k, v) => widgets.add(PDFNetwork(title: k, uri: v)));
      for (String s in widget.modules) {
        if (s.isNotEmpty) {
          widgets.add(Module(modName: s));
        }
      }
      return widgets;
    } catch (e) {
      return widgets;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          // leading: MaterialButton(
          //   padding: const EdgeInsets.all(0.0),
          //   onPressed: () {
          //     Navigator.pushReplacement(
          //         context, MaterialPageRoute(builder: (context) => Home()));
          //   },
          //   child: const Image(
          //     image: AssetImage('images/logo.png'),
          //   ),
          // ),
          title: Text(widget.modName),
          titleSpacing: 2.0,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: files(),
          ),
        ),

      ),
    );
  }
}
