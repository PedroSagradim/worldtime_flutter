import 'package:flutter/material.dart';
import 'package:projeto_fusos/services/world_time.dart';

class ChooseRegion extends StatefulWidget {
  @override
  _ChooseRegionState createState() => _ChooseRegionState();
}

class _ChooseRegionState extends State<ChooseRegion> {

  List<String> regions = [
    'Africa',
    'America',
    'Antarctica',
    'Asia',
    'Atlantic',
    'Australia',
    'Europe',
    'Pacific',
    'Indian'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: const Text('Escolha uma região'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
          itemCount: regions.length,
          itemBuilder: (context, index){
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 1,horizontal: 4),
              child: Card(
                child: ListTile(
                  title: Text(regions[index]),
                  onTap: () async{
                   dynamic result = await Navigator.pushNamed(context, '/location',arguments: regions[index]);
                   Navigator.pop(context,{
                     'time': result['time'],
                     'location': result['location'],
                     'isDayTime': result['isDayTime'],
                     'flag': result['flag']
                   });
                  },),
              ),
            );
          }
      ),
    );
  }
}
