import 'dart:convert';
import 'dart:io';
import 'package:encrypt/encrypt.dart';
import 'package:encrypt/encrypt_io.dart';
import 'package:flutter/foundation.dart';
import 'package:pointycastle/asymmetric/api.dart';

import 'package:flutter/material.dart';

Future<String> rsaEncrypt(String plainText) async{
  final publicKey = await parseKeyFromFile<RSAPublicKey>('files/mypublickey.pem');
  final privKey = await parseKeyFromFile<RSAPrivateKey>('files/alice_private.pem');
  final encrypter = Encrypter(RSA(publicKey: publicKey, privateKey: privKey));
  final encrypted = encrypter.encrypt(plainText);
  if (kDebugMode) {
    print(encrypted.base64);
  }
  return encrypted.base64;
}

Future<String> rsaDecrypt(String encrypted) async{
  final publicKey = await parseKeyFromFile<RSAPublicKey>('files/mypublickey.pem');
  final privKey = await parseKeyFromFile<RSAPrivateKey>('files/alice_private.pem');
  final encrypter = Encrypter(RSA(publicKey: publicKey, privateKey: privKey));
  final decrypted = encrypter.decrypt(Encrypted.fromBase64(encrypted));
  if (kDebugMode) {
    print(decrypted);
  }
  return decrypted;
}

var kPrimaryColor = Colors.green.shade900 /*Color(0xff94A89A)*/;
var kSecondaryColor = Colors.white;
var kBackgroundColor = Colors.black45 /*Color(0xffC9B7AD)*/;
var kTertiaryColor = Colors.grey.shade900;

var kTextStyle = TextStyle(
  color: kPrimaryColor,
  fontWeight: FontWeight.bold,
  fontSize: 20.0,
);


Future<String> apiPost(String url, Map jsonMap) async {
  HttpClient httpClient = HttpClient();
  HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
  request.headers.set('content-type', 'application/json');
  request.add(utf8.encode(json.encode(jsonMap)));
  HttpClientResponse response = await request.close();
  // todo - you should check the response.statusCode
  if (kDebugMode) {
    print(response.statusCode);
  }
  String reply = await response.transform(utf8.decoder).join();
  httpClient.close();
  return reply;
}

Future<List<String>> apiGet(String url) async {
  HttpClient httpClient = HttpClient();
  HttpClientRequest request = await httpClient.getUrl(Uri.parse(url));
  request.headers.set('content-type', 'application/json');
  // request.add(utf8.encode(json.encode(jsonMap)));
  HttpClientResponse response = await request.close();
  // todo - you should check the response.statusCode
  if (kDebugMode) {
    print(response.statusCode);
  }
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



