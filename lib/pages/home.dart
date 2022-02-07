import 'package:flutter/material.dart';
import 'dart:async';
import 'package:projeto_fusos/services/world_time.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Map data = {};

  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 1), (Timer t) => _getTime());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context)?.settings.arguments as Map;

    //Setando Background
    String bgImage = data['isDayTime'] ? 'day.png' : 'night.png';
    Color? bgColor = data['isDayTime'] ? Colors.lightBlue : Colors.indigo[800];
    Color? textColor = data['isDayTime'] ? Colors.lightBlue : Colors.indigo[900];

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/$bgImage'), fit: BoxFit.cover),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0,120,0,0),
            child: Column(
              children: [
                Center(
                  child: TextButton.icon(
                    onPressed: () async{
                      dynamic result = await Navigator.pushNamed(context, '/region');
                      setState(() {
                        data = {
                          'time': result['time'],
                          'location': result['location'],
                          'isDayTime': result['isDayTime'],
                          'url': result['url'],
                          'flag': result['flag']
                        };
                      });
                    },
                    icon: Icon(Icons.edit_location, color: textColor),
                    label: Text('Editar local', style: TextStyle(color: textColor))
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        data['location'],
                        style: TextStyle(
                          fontSize: 28,
                          letterSpacing: 2,
                          color: textColor
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    data['time'],
                    style: TextStyle(
                        fontSize: 60,
                        letterSpacing: 2,
                        color: textColor
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void _getTime() async{
    if (data.isNotEmpty) {
      WorldTime wrld = WorldTime(location: data['location'], flag: data['flag'], url: data['url']);
      await wrld.getTime();
      setState(() {
        data['time'] = wrld.time;
      });
    }
  }
}
