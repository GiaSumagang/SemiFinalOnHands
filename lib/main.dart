import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'homePage.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(primarySwatch: Colors.purple,
    ),
    title: 'MyApp',
    home: const Myhomepage(home: '',),
  ));
}
