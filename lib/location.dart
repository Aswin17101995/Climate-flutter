import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class Location {
  String latitude = "";
  String longitude = "";
  String temperature ="";
  String place ="";
  String weather = "";

  Future<void> getLocationinfo() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    latitude = position.latitude.toString();
    longitude = position.longitude.toString();
  }
  Future<void> getWhatherData()async{
    var apiKey = 'd3071eae7af8c0fb2cc5be8cb7e82bac';
    var url = Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey');
    print(url);
    var response;
    try{
       response = await http.get(url);
       var wea = jsonDecode(response.body)['weather'][0]['description'].toString();
       var temp = (jsonDecode(response.body)['main']['temp'] - 273.15).toStringAsFixed(0);
       var  pla = jsonDecode(response.body)['name'].toString();
       print(response.body);
       weather = wea;
       temperature = temp;
       place = pla;
    }
    catch(e){
      print(e);
    }

  }
}
