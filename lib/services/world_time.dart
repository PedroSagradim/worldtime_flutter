import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

//CLASS WORLDTIME
class WorldTime {

  String location; //local
  String time=''; //tempo do local
  String flag; //url para bandeirinha
  String url; // -- LOCATION
  bool? isDayTime;

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async{
    try{
      //request
      Response response = await(get(Uri.parse('http://worldtimeapi.org/api/timezone/$url')));
      Map data = jsonDecode(response.body);

      //trabalhando com o response
      DateTime now = DateTime.parse(data['datetime']);
      int offset = int.parse(data['utc_offset'].substring(0,3));
      now = now.add(Duration(hours: offset));

      isDayTime = now.hour > 5 && now.hour < 19 ? true : false;
      time = DateFormat.jms().format(now);
    }catch(e){
      print('ERRO: $e');
    }
  }
}