import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mi2a_map/pages/custom_box_map.dart';
import 'package:flutter_mi2a_map/pages/detail_hotel_page.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();

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

  final List<Map<String, dynamic>> _listHotel = [
    {
      'namaTempat': 'RedDoorz Plus Syariah @ Polamas Andalas',
      'gambar': 'assets/images/hotel1.jpg',
      'harga': 'Rp. 200.000',
      'lattitude': -0.9369557563214894,
      'longitude': 100.377636307855,
      'rating': 4.3,
      'keterangan':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam sagittis vitae diam a dictum. Duis quis mollis turpis, et pretium odio. Aliquam porta, dui at consectetur imperdiet, mauris urna dictum sem, et condimentum nisi mauris sodales ex. Suspendisse sit amet dapibus urna, at sollicitudin arcu. Morbi neque felis, volutpat nec vulputate at, molestie a est. Phasellus convallis lectus vel sapien sollicitudin aliquet. Nunc in metus purus.',
    },
    {
      'namaTempat': 'DAIMA Gardenstay',
      'gambar': 'assets/images/hotel2.jpg',
      'harga': 'Rp. 330.000',
      'lattitude': -0.93864105431432,
      'longitude': 100.37837179386223,
      'rating': 4.4,
      'keterangan':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam sagittis vitae diam a dictum. Duis quis mollis turpis, et pretium odio. Aliquam porta, dui at consectetur imperdiet, mauris urna dictum sem, et condimentum nisi mauris sodales ex. Suspendisse sit amet dapibus urna, at sollicitudin arcu. Morbi neque felis, volutpat nec vulputate at, molestie a est. Phasellus convallis lectus vel sapien sollicitudin aliquet. Nunc in metus purus.',
    },
  ];

  Set<Marker> _createMarker() {
    Set<Marker> markers = {};
    for (var hotel in _listHotel) {
      final LatLng koordinat = LatLng(hotel['lattitude'], hotel['longitude']);
      markers.add(
        Marker(
          markerId: MarkerId(hotel['namaTempat']),
          position: koordinat,
          onTap: () {
            _customInfoWindowController.addInfoWindow!(
              CustomBoxMap(
                gambar: hotel['gambar'],
                namaTempat: hotel['namaTempat'],
                rating: hotel['rating'],
                harga: hotel['harga'],
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => DetailHotelPage(hotelData: hotel,)),
                  );
                },
              ),
              koordinat,
            );
          },
        ),
      );
    }

    return markers;
  }

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
            // marker
            markers: _createMarker(),
            // controller
            onMapCreated: (controller) {
              _customInfoWindowController.googleMapController = controller;
            },
            onTap: (position) => _customInfoWindowController.hideInfoWindow!(),
          ),
          CustomInfoWindow(
            controller: _customInfoWindowController,
            height: 200,
            width: 200,
            offset: 50,
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
