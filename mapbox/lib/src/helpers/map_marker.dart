import 'package:latlong2/latlong.dart';

class MapMarker {
  MapMarker(
      {required this.image,
      required this.title,
      required this.address,
      required this.location});

  final String image;
  final String title;
  final String address;
  final LatLng location;
}

// fake ubications
final _locations = [
  LatLng(31.612884314636165, -8.188290133677345),
  LatLng(32.488723424956, -8.23619971128054),
  LatLng(33.00774241523333, -3.6257123130427953),
  LatLng(33.329117858261085, -7.515108512419333),
  LatLng(34.25854689459816, -2.5740729973315455),
  LatLng(26.849175997418826, -9.82911251829363),
  LatLng(30.110159861943146, -6.260454002662053),
];

const _path = 'assets/';

// instancias de la classe
final mapMarkers = [
  MapMarker(
      image: '${_path}download.jpg',
      title: 'Marcos',
      address: 'Address Marcos 123',
      location: _locations[0]),
  MapMarker(
      image: '${_path}burger.jpg',
      title: 'bandera',
      address: '40000, Bd Abdelkarim Al Khattabi',
      location: _locations[1]),
  MapMarker(
      image: '${_path}pizza.jpg',
      title: 'paplo',
      address: 'Address Marcos 123',
      location: _locations[2]),
  MapMarker(
      image: '${_path}images.jpg',
      title: 'mohssine',
      address: 'Address Marcos 123',
      location: _locations[3]),
  MapMarker(
      image: '${_path}download.jpg',
      title: 'ali',
      address: 'Address Marcos 123',
      location: _locations[4]),
  MapMarker(
      image: '${_path}download.jpg',
      title: 'mc burger',
      address: '40000, Bd Abdelkarim Al Khattabi',
      location: _locations[5]),
  MapMarker(
      image: '${_path}download.jpg',
      title: 'adios',
      address: 'Address Marcos 123',
      location: _locations[6]),
];
