import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MapsMain(),
    );
  }
}

class MapsMain extends StatefulWidget {
  @override
  _MapsMainState createState() => _MapsMainState();
}

class _MapsMainState extends State<MapsMain> {

  Set<Marker> _Markers = HashSet<Marker>();
  GoogleMapController _mapController;
  BitmapDescriptor _markerIcon;

  @override
  void initState() {
    super.initState();
    _addMarkerIcon();
  }

  void _addMarkerIcon() async {
    _markerIcon = await BitmapDescriptor.fromAssetImage(ImageConfiguration(), "assets/laptop.png");
  }

  void _addMapStyle() async {
    String style = await DefaultAssetBundle.of(context).loadString('assets/mapStyle.json');
    _mapController.setMapStyle(style);
  }

  void _onMapCreated(GoogleMapController controller){
    _mapController = controller;

    setState(() {
      _Markers.add(Marker(
        markerId: MarkerId("0"), 
        position: LatLng(37.42796133580664, -122.085749655962),
        infoWindow: InfoWindow(
          title: "Maker Place",
          snippet: "greate place",
          ),
          icon: _markerIcon,
          ));
    });
    
    _addMapStyle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Maps"),),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: 
          CameraPosition(
            target: LatLng(37.42796133580664, -122.085749655962),
            zoom: 14,
          ),
          markers: _Markers,
        ),
    );
  }
}