import 'package:flutter/material.dart';
import 'package:projeto_fusos/pages/home.dart';
import 'package:projeto_fusos/pages/loading.dart';
import 'package:projeto_fusos/pages/location.dart';
import 'package:projeto_fusos/pages/choose_region.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/',
  routes: {
    '/': (context) => LoadingScreen(),
    '/home': (context) => HomeScreen(),
    '/location': (context) => ChooseLocation(),
    '/region': (context) => ChooseRegion()
  },
));