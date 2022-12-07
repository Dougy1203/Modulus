import 'dart:convert';
import 'dart:io';
import 'package:encrypt/encrypt.dart';
import 'package:encrypt/encrypt_io.dart';
import 'package:pointycastle/asymmetric/api.dart';

import 'package:flutter/material.dart';

String kPrivateKey = '-----BEGIN ENCRYPTED PRIVATE KEY-----MIIFLTBXBgkqhkiG9w0BBQ0wSjApBgkqhkiG9w0BBQwwHAQI+cCbhF11Gt4CAggAMAwGCCqGSIb3DQIJBQAwHQYJYIZIAWUDBAECBBAgIxSSM3fuqnbxddNQkiL5BIIE0I/6poydAFnieTG6o1DETdm7Pqlv4vP2799TO7qUNCkV54uDDATRPxV/CGrhpldrb2HLcq2Jng9ffHRdOQxJxcoHfbMu3wjiSpKIjVA2etDr8m/XjOjtGyp0t8CsFuoKVNfaOmOCYMumsGBmow2c3xpzEdS1OaOFLwiHomScQz/cmUu7xTwINGSLtDGQV7inG3i1IxJ3VV5ISn6tAK/LxkWmhIQQQRClIwOM17c1g9R4vIfr0jHXo+ma1/32Nc5h8byb5jt7tgDdJsP0nW8gOD2slyXNQLCDBXH1MaN/OcGyNCPbFdJ3zq+I6bd4ICzwoo7J1QL8d3he4ygB+WedKq1Ug+D4lJ3hoalxomIxomXHTK0DSEFgSJ9gTlhQKXCCKf3KYpAyIPEqfQQaPWyGvNyNqplDgvjGCVlNvxwZvJOFGZHOaPa4tY+yAynUDFIkEmSuKFhYDS1CqK1d2m3RYKjRb+K0VuCtPV5yf/JB9OCSi1kE4Xl9FCwi1/uRu4+sYrZXjOjpGGAOiQlG+iVKXMw095c0idw7Ng/q1w1q2OEKN1S2+XbDcRd06KDLs8SW7ZbrwAYNZunRJziloG1xp/AJxLSNy8lzWQWpvAg/s3GFZf/uD3WbHkZUX5Hjy7guAOHPm2lI7ZAuGsWQUijbaW/DBOTEsYQDml0bFxzToqA1IgBxTDT8h21ZYMLyq0ytcEXNlsbUBj3oQ5PHWipodUBhd2UleGD+VrGBCSTRo6Fi177tvRMoNpS9OBoELy98bcH7T+CtvWFqcaDhllrEbq6IXJQotprM3ECOJ1i7L3nj4I6g839flPhnfJRSKX6PJR+1BHs60Bfi/zV6XEhyzOGhoxNxqMbiGCMRPfCKReHLnLnNouOAmOK13PEBJHc9mWDsqtMwzSU9FVMsvfVxruGyhsXK05twf+CBBzJmy+BRsgbLK6uaTTVXoKFGiJIA0nt1amiUKYJCeC4V3/W+tDyEXQo48CHy8F4+OwdZuxGs5FbGS0t3gmGM9/otUl82BLv4e0/+rPHAXoOEM/nO93WNWgR0hOiTqsC7ZoV4vDP8Xk/xyQnTWTRiwJHa7EA3uYkNYe6lOGu9q0cLfYLzZMy5eJ3OzlKDWxk6FBV2QFshiMmFt83Qn4P9Wq3e7p6dRBFqb1+6lHPTZNABdpa7hzo/P34C4xZDuHljQH/kLugMlRZDGK0hHrkiaebDyszal0vHOd7D6tX1PCRJ5hf+y5Wgia0RL76mOFbbECQirOGSv4m0ot965RaIDADA06T2kG6SIleRp93vNER/T2GDiYjX8NqF552hiv+jK5fULlGgIZUnmiwL1JgGfGDnQUMyi78piSaMpcvEyDWZn7AiRvsfvd+0vKzyOFOFLN0QgabD2isaZflzZEwHzJT3hGMX8V1ODtxrjDcn7dbxJykN03B4l/PqmYm1g3zyMUXhyfGCIZQ5J1JIBYZ6X0YABb4GRL4bgkWegn51A5JxZjHW4KvsS1M/0kkr+fX3BhPQwJ/xVbLdcxJ5NsmB0krBQFI3pX2CdQs1TpSU1jmJh3eAkFSoTIK2/P0BzbAEL3UFvqWG+2+Aqk5bj1h5M2coBQaeKw0r8/T5AU7Ity94Wi1HoruzOUcDml44THhoDMYoJMhf-----END ENCRYPTED PRIVATE KEY-----';
String kPublicKey = '-----BEGIN PUBLIC KEY-----MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEApPDdwVW38QVvVnje0xz6RCkbaVby9h9uMCnCNnGikHV2V14GaI8veZPKqqDdEASWV/jTqJtSLFVZjjSSHgnIfu+E48v/fExH1rYQxPwfZVq3jMlXgI0Afr1Lb4Vmt/OAkk/O8PHGhUKMXyXg/JciWzUUET4klIJNnj+V8bXaC09u55roKbDw43+niMF9owMqyXwxt/6EBfCGK96RbY266lMf0SQiDgza5k5doN1w2M4XoBWU4OMfvew6680ssFYUP5f+yUweszKt7jBBeCtxCD1jK3qyuZDgx4n7mNKrvft/X1WZeBVhE+NCSknOS4sN6nNGJ4G8Yyj4njsn9HpcqwIDAQAB-----END PUBLIC KEY-----';

Future<String> RSAEncrypt(String plainText) async{
  final publicKey = await parseKeyFromFile<RSAPublicKey>('files/mypublickey.pem');
  final privKey = await parseKeyFromFile<RSAPrivateKey>('files/alice_private.pem');
  final encrypter = Encrypter(RSA(publicKey: publicKey, privateKey: privKey));
  final encrypted = encrypter.encrypt(plainText);
  print(encrypted.base64);
  return encrypted.base64;
}

Future<String> RSADecrypt(String encrypted) async{
  final publicKey = await parseKeyFromFile<RSAPublicKey>('files/mypublickey.pem');
  final privKey = await parseKeyFromFile<RSAPrivateKey>('files/alice_private.pem');
  final encrypter = Encrypter(RSA(publicKey: publicKey, privateKey: privKey));
  final decrypted = encrypter.decrypt(Encrypted.fromBase64(encrypted));
  print(decrypted);
  return decrypted;
}

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



