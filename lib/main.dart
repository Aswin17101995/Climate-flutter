import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'location.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
void main() {
  runApp(MaterialApp(
    home: Scaffold(
      // appBar: AppBar(
      //   title: Text("CLIMA",style: TextStyle(
      //     fontWeight: FontWeight.w900,
      //     fontSize: 28
      //   ),),
      // ),
      body: SafeArea(
        child: Clima(),
      ),
    ),
  ));
}

class Clima extends StatefulWidget {
  const Clima({Key? key}) : super(key: key);

  @override
  State<Clima> createState() => _ClimaState();
}

class _ClimaState extends State<Clima> {
  Location myLocation = Location();
  var place;
  var temperature;
  var description;
  bool loading = true;
  void getLocation()async{
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied)
      {
        permission = await Geolocator.requestPermission();
        if(permission == LocationPermission.denied)
          {
            return;
          }
      }
    await myLocation.getLocationinfo();
    await myLocation.getWhatherData();
    setState(() {
      place = myLocation.place;
      description = myLocation.weather;
      temperature = myLocation.temperature;
      loading = false;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    getLocation();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if(loading)...[
          Expanded(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Container(
              width: double.infinity,
              child: LoadingAnimationWidget.inkDrop(color: Colors.black, size: 200),
            )],
          ))
       ]
        else...[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.all(10),
                child: Icon(Icons.location_on,size: 40,),
              ),
              Text(place,style: TextStyle(
                  fontSize: 40
              ),)
            ],
          ),
          Expanded(child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [ Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment:CrossAxisAlignment.start,
                children: [
                  Text(temperature,style: TextStyle(
                    fontSize: 150,
                  ),),
                  Text('\u1d3c',style: TextStyle(
                    fontSize: 44,
                    fontWeight: FontWeight.w900,
                  ),)
                ],
              ),
            ),
              Container(
                width: double.infinity,
                // margin: EdgeInsets.only(bottom: 120),
                child: Text(description,textAlign: TextAlign.center,style: TextStyle(
                    fontSize: 40
                ),),
              )],
          )
          )
        ]
      ],
    );
  }
}
