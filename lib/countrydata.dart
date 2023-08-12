
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CountryData {
  final String name;
  final LatLng latLng;

  CountryData(this.name, this.latLng);

  static List<CountryData> countryList = [
    CountryData('Sydney', const LatLng(-33.86, 151.20)),
    CountryData('New York', const LatLng(40.71, -74.01)),
    CountryData('London', const LatLng(51.51, -0.13)),
    CountryData('Tokyo', const LatLng(35.68, 139.76)),
    CountryData('Paris', const LatLng(48.86, 2.35)),
    CountryData('Rome', const LatLng(41.89, 12.49)),
    CountryData('Cairo', const LatLng(30.04, 31.24)),
    CountryData('Beijing', const LatLng(39.90, 116.41)),
    CountryData('Moscow', const LatLng(55.75, 37.61)),
    CountryData('Rio de Janeiro', const LatLng(-22.91, -43.17)),
    CountryData('Mumbai', const LatLng(19.07, 72.87)),
    CountryData('Berlin', const LatLng(52.52, 13.40)),
    CountryData('Toronto', const LatLng(43.70, -79.42)),
     CountryData('Mumbai', const LatLng(19.07, 72.87)),
    CountryData('Berlin', const LatLng(52.52, 13.40)),
    CountryData('Toronto', const LatLng(43.70, -79.42)),
    CountryData('Singapore', const LatLng(1.35, 103.82)),
    CountryData('Istanbul', const LatLng(41.01, 28.98)),
    CountryData('Dubai', const LatLng(25.27, 55.30)),
    CountryData('Seoul', const LatLng(37.56, 126.97)),
   
CountryData('Islamabad', const LatLng(33.6844, 73.0479)),

  ];
}