import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //tipe map
  MapType _mapType = MapType.normal;

  //style map
  String? _styleMap;

  //method klik
  void _onMapTypeButtonPressed() {
    setState(() {
      _mapType =
          _mapType == MapType.normal ? MapType.satellite : MapType.normal;
    });
  }

  //method _loadFileStyleMap
  Future<void> _loadFileStyleMap(String path) async {
    String style = await rootBundle.loadString(path);
    setState(() {
      _styleMap = style;
    });
  }

  //standard
  void _standardStyle() => setState(() => _styleMap = null);
  //dark
  void _darkStyle() => _loadFileStyleMap('assets/map_style/dark.json');
  //retro
  void _retroStyle() => _loadFileStyleMap('assets/map_style/retro.json');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(-0.9294517008441783, 100.37253093611072),
              zoom: 12.8,
            ),
            mapType: _mapType,
            //style map
            style: _styleMap,
          ),
          Positioned(
            bottom: 16,
            left: 16,
            child: Column(
              children: [
                FloatingActionButton(
                  onPressed: _onMapTypeButtonPressed,
                  backgroundColor: Colors.blue,
                  child:
                      _mapType == MapType.normal
                          ? Icon(Icons.map, color: Colors.white)
                          : Icon(Icons.satellite_alt, color: Colors.white),
                ),
                SizedBox(height: 10),
                FloatingActionButton(
                  onPressed: _standardStyle,
                  backgroundColor: Colors.yellow,
                  child: Icon(Icons.sunny, color: Colors.white),
                ),
                SizedBox(height: 10),
                FloatingActionButton(
                  onPressed: _darkStyle,
                  backgroundColor: Colors.black,
                  child: Icon(Icons.dark_mode, color: Colors.white),
                ),
                SizedBox(height: 10),
                FloatingActionButton(
                  onPressed: _retroStyle,
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.location_city, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
