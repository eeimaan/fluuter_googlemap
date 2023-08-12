import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'countrydata.dart'; 
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';


void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  late GoogleMapController mapController;
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  static const LatLng _center = LatLng(20.0, 0.0);
  late final Location _location = Location();

  // Move to user's current location
  void _moveToCurrentLocation() async {
    if (await _requestLocationPermission()) {
      LatLng myLocation = await _getUserLocation();
      mapController.animateCamera(
        CameraUpdate.newLatLng(myLocation),
      );
    }
  }

  // Get user's current location
  Future<LatLng> _getUserLocation() async {
    try {
      LocationData locationData = await _location.getLocation();
      return LatLng(locationData.latitude!, locationData.longitude!);
    } catch (e) {
      print("Error getting user location: $e");
      return const LatLng(0, 0); // Return a default location if an error occurs
    }
  }

  // Request location permission
  Future<bool> _requestLocationPermission() async {
    PermissionStatus permission = await _location.requestPermission();
    return permission == PermissionStatus.granted;
  }
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Set<Marker> _createMarkers() {
    return CountryData.countryList.map((country) {
      return Marker(
        markerId: MarkerId(country.name),
        position: country.latLng,
        infoWindow: InfoWindow(
          title: country.name,
        ),
      );
    }).toSet();
    
  }

  void _startSearch() {
    setState(() {
      _isSearching = true;
    });
  }

  void _cancelSearch() {
    setState(() {
      _isSearching = false;
      _searchController.clear();
    });
  }

  void _performSearch() {
    String query = _searchController.text;
    CountryData country = CountryData.countryList.firstWhere(
      (country) => country.name.toLowerCase() == query.toLowerCase(),
      orElse: () => CountryData(
        'Not Found',
        const LatLng(0, 0),
      ),
    );
    mapController.animateCamera(
      CameraUpdate.newLatLng(country.latLng),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(_isSearching ? 'Search' : 'Maps'),
          actions: [
            if (_isSearching)
              IconButton(
                icon: const Icon(Icons.clear),
                onPressed: _cancelSearch,
              )
            else
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: _startSearch,
              ),
            IconButton(
              icon: const Icon(Icons.my_location),
              onPressed: () {
                _moveToCurrentLocation();
              },
            ),
          ],
        ),
        body: Column(
          children: [
            if (_isSearching)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        decoration: const InputDecoration(
                          hintText: 'Search country...',
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: _performSearch,
                    ),
                  ],
                ),
              ),
            Expanded(
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: const CameraPosition(
                  target: _center,
                  zoom: 2.0,
                ),
                markers: _createMarkers(),
              ),
            ),
          ],
        ),
      ),
    );
  }


}