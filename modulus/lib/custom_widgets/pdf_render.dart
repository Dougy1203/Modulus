import 'dart:io';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../constants/constants.dart';

class PDFNetwork extends StatefulWidget{
  const PDFNetwork({super.key, required this.uri, required this.title});
  final String uri;
  final String title;
  @override
  State<PDFNetwork> createState() => _PDFNetworkState();
}

class _PDFNetworkState extends State<PDFNetwork> {
  var height = 0.0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          MaterialButton(
            child: SizedBox(
              width: double.infinity,
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                      color: kPrimaryColor,
                    ),
                  ),
                  Icon(
                    Icons.expand_circle_down_outlined,
                    size: 40.0,
                    color: kPrimaryColor
                  ),
                ],
              ),
            ),
            onPressed: () {
              setState(() {
                if (height == 0.0) {
                  height = 500.0;
                } else {
                  height = 0.0;
                }
              });
            },
          ),
          SizedBox(
            width: 400.0,
            height: height,
            child: SfPdfViewer.network(widget.uri),
          ),
        ],
      ),
    );
  }
}

class PDFLocal extends StatefulWidget {
  const PDFLocal({super.key, required this.uri, required this.title});
  final String uri;
  final String title;
  @override
  State<PDFLocal> createState() => _PDFLocalState();
}

class _PDFLocalState extends State<PDFLocal> {
  var height = 0.0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          MaterialButton(
            child: SizedBox(
              width: double.infinity,
              height: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                      color: kPrimaryColor,
                    ),
                  ),
                  Icon(
                      Icons.expand_circle_down_outlined,
                      size: 40.0,
                      color: kPrimaryColor
                  ),
                ],
              ),
            ),
            onPressed: () {
              setState(() {
                if (height == 0.0) {
                  height = 600.0;
                } else {
                  height = 0.0;
                }
              });
            },
          ),
          SizedBox(
            width: 400.0,
            height: height,
            child: SfPdfViewer.file(File(widget.uri)),
          ),
        ],
      ),
    );
  }
}

class PDFAsset extends StatefulWidget {
  const PDFAsset({super.key, required this.uri, required this.title});
  final String uri;
  final String title;
  @override
  State<PDFAsset> createState() => _PDFAssetState();
}

class _PDFAssetState extends State<PDFAsset> {
  var height = 0.0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          MaterialButton(
            child: SizedBox(
              width: double.infinity,
              height: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                      color: kPrimaryColor,
                    ),
                  ),
                  Icon(
                      Icons.expand_circle_down_outlined,
                      size: 40.0,
                      color: kPrimaryColor
                  ),
                ],
              ),
            ),
            onPressed: () {
              setState(() {
                if (height == 0.0) {
                  height = 600.0;
                } else {
                  height = 0.0;
                }
              });
            },
          ),
          SizedBox(
            width: 400.0,
            height: height,
            child: SfPdfViewer.asset(widget.uri),
          ),
        ],
      ),
    );
  }
}

