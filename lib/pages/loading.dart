import 'package:flutter/material.dart';
import 'package:projeto_fusos/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  void setUpWorldTime() async{
    WorldTime tDefault = WorldTime(location:'São Paulo', flag:'brasil.png', url:'America/Sao_Paulo');
    await tDefault.getTime();

    Navigator.pushReplacementNamed(
        context,
        '/home',
        arguments: {
          'location': tDefault.location,
          'flag': tDefault.flag,
          'time': tDefault.time,
          'isDayTime': tDefault.isDayTime
        });
  }

  @override
  void initState(){
    super.initState();
    setUpWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[200],
      body: const Center(
          child: SpinKitCircle(
            color: Colors.white,
            size: 50,
          ),
      ),
    );
  }
}
