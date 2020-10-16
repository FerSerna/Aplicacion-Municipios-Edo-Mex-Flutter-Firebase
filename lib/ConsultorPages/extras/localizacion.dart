import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


Completer<GoogleMapController> _controller = Completer();
CameraPosition _initialPosition;

void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
}

class DesplayMapa extends StatefulWidget {
  DesplayMapa(String latitud, String longitud){
    double lat = double.parse(latitud);
    double lon = double.parse(longitud);
    _initialPosition = CameraPosition(target: LatLng(lat, lon),zoom: 13);
  }


  @override
  _DesplayMapa createState() => _DesplayMapa();
    
  }
  
  class _DesplayMapa  extends State<DesplayMapa>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Tu municipio en Maps'),
          centerTitle: true,
        ),
        body: Stack(
          children: <Widget>[
            GoogleMap(    
              onMapCreated: _onMapCreated,
              initialCameraPosition: _initialPosition,
            ),
          ],
        ));
  }
}