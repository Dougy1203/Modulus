import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import '../constants/constants.dart';
import '../custom_widgets/pdf_render.dart';
import '../pages/home.dart';
import 'package:http/http.dart' as http;

import '../pages/page_module.dart';

class Module extends StatefulWidget {
  const Module({super.key, required this.modName});
  final String modName;
  // final List<String>
  @override
  State<Module> createState() => _ModuleState();
}

class _ModuleState extends State<Module> {
  dynamic module;
  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: kPrimaryColor,
      elevation: 40.0,
      color: kPrimaryColor.withOpacity(0.45),
      borderOnForeground: true,
      child: MaterialButton(
        onPressed: () async {
          var mods = await apiGet('http://10.0.2.2:8888/modulemicroservice/mod/getModules/${widget.modName}');
          var tempFiles = await http.get(Uri.parse('http://10.0.2.2:8888/modulemicroservice/mod/getFiles/${widget.modName}'));
          var roles = await apiGet('http://10.0.2.2:8888/modulemicroservice/mod/getRoles/${widget.modName}');
          List<String> strings = tempFiles.body.split(',');
          Map<String, String> files = <String,String>{};
          for(String a in strings){
            a = a.replaceAll('"', '');
            a = a.replaceAll('{', '');
            a = a.replaceAll('}', '');
            if(a.isNotEmpty){
              String key = a.substring(0, a.indexOf(':'));
              String value = a.substring(a.indexOf(':')+1, a.length);
              files[key] = value;
            }
          }
          // print(mods);
          // print(roles);
          // print(widget.modName);

          Navigator.push(context, MaterialPageRoute(builder: (context) => ModulePage(modName: widget.modName, files: files, modules: mods, roles: roles,)));
        },
        height: 200,
        minWidth: 400,
        child: Center(
          child: Text(
            widget.modName,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 40,
              fontWeight: FontWeight.bold,
              letterSpacing: 4.0,
            ),

          ),
        ),
      ),
    );
  }
}
