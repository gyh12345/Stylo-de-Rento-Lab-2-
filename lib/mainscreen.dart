import 'package:flutter/material.dart';
/*import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:styloderento/registerscreen.dart';
import 'package:styloderento/mainscreen.dart';*/

void main() => runApp(MainScreen());

class MainScreen extends StatefulWidget{
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(image:DecorationImage
              (image:AssetImage("assets/images/main.png"),fit: BoxFit.cover))
  );
  }
}