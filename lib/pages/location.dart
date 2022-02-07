import 'package:flutter/material.dart';
import 'package:projeto_fusos/services/world_time.dart';
import 'package:http/http.dart';
import 'dart:convert';

class ChooseLocation extends StatefulWidget {
  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  List<WorldTime> location = [];
  String region = 'America';
  int contador = 0; //variavel da gambiarra

  Future<void> ListLocations(String nome) async {
    try {
      //request
      Response response = await (get(Uri.parse('http://worldtimeapi.org/api/timezone/$nome')));
      List<dynamic> data = jsonDecode(response.body);
      String local;

      //trabalhando com o response
      for (var i = 0; i < data.length; i++) {
        local = data[i].toString();
        location.add(WorldTime(
            location: local.substring(local.indexOf('/') + 1).replaceAll('_', ' '),
            flag: 'blank.png',
            url: data[i]));
      }
    } catch (e) {
      print('ERRO: $e');
    }
  }

  void updateTime(index) async {
    WorldTime instance = location[index];
    await instance.getTime();

    //homescreen
    Navigator.pop(context, {
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'url': instance.url,
      'isDayTime': instance.isDayTime
    });
  }

  @override
  Widget build(BuildContext context) {

    //gambiarra que eu fiz pra dar refresh na tela com setState
    //o setState chama o build, entao esta setado um contador para ele nao chamar mais de uma vez nesse loop
    void refreshList() async{
      if (contador < 1){
        region = ModalRoute.of(context)?.settings.arguments as String;
        await ListLocations(region);
        setState(() {});
        contador++;
      }
    }
    refreshList();

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: const Text('Escolha uma localização'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
          itemCount: location.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
              child: Card(
                child: ListTile(
                  onTap: () {
                    updateTime(index);
                  },
                  title: Text(location[index].location),
                ),
              ),
            );
          }),
    );
  }
}
