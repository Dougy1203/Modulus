import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

var kPrimaryColor = Colors.green.shade900 /*Color(0xff94A89A)*/;
var kSecondaryColor = Colors.blue.shade900;
var kBackgroundColor = Colors.black45 /*Color(0xffC9B7AD)*/;
var kTertiaryColor = Colors.grey.shade900;

var kTextStyle = TextStyle(
  color: kPrimaryColor,
  fontWeight: FontWeight.bold,
  fontSize: 20.0,
);


Future<String> apiPost(String url, Map jsonMap) async {
  HttpClient httpClient = new HttpClient();
  HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
  request.headers.set('content-type', 'application/json');
  request.add(utf8.encode(json.encode(jsonMap)));
  HttpClientResponse response = await request.close();
  // todo - you should check the response.statusCode
  print(response.statusCode);
  String reply = await response.transform(utf8.decoder).join();
  httpClient.close();
  return reply;
}

Future<List<String>> apiGet(String url) async {
  HttpClient httpClient = new HttpClient();
  HttpClientRequest request = await httpClient.getUrl(Uri.parse(url));
  request.headers.set('content-type', 'application/json');
  // request.add(utf8.encode(json.encode(jsonMap)));
  HttpClientResponse response = await request.close();
  // todo - you should check the response.statusCode
  print(response.statusCode);
  String reply = await response.transform(utf8.decoder).join();
  httpClient.close();

  var strings = reply;
  strings = strings.replaceAll('"', '');
  strings = strings.replaceAll('[', '');
  strings = strings.replaceAll(']', '');
  List<String> stringy = strings.split(',');
  return stringy;
}

SnackBar kSnack(String content){
  return SnackBar(
    content: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(content, style: kTextStyle),
      ],
    ),
    shape: const StadiumBorder(),
    backgroundColor: Colors.grey.shade900,
    padding: const EdgeInsets.symmetric(horizontal: 5.0),

  );
}



