import 'dart:async';

import 'package:flutter/material.dart';

class intro_screen extends StatefulWidget {
  const intro_screen({Key? key}) : super(key: key);

  @override
  State<intro_screen> createState() => _intro_screenState();
}

class _intro_screenState extends State<intro_screen> {
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 5), () {
      Navigator.of(context)
          .pushNamedAndRemoveUntil('web_page', (route) => false);
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Browser",
          style: TextStyle(
            fontSize: 26,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(image: AssetImage("assets/images/intro_pic.gif",)),
          SizedBox(height: 40,),
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}
