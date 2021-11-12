import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';

import 'package:latlong2/latlong.dart';
import 'package:mapbox/src/helpers/map_marker.dart';

const MAPBOX_ACCESS_TOKEN =
    'pk.eyJ1IjoibG1hcmlvdWgiLCJhIjoiY2t2dGQwMjExMjJsaTJvcWg5YTR3djYzeSJ9.F8Gu42lK9zNskxqjU5JvHw';
//const MAPBOX_STYLE = 'mapbox/dark-v10';
const MAPBOX_STYLE = 'mapbox.mapbox-streets-v8';

const MAKER_COLOR = Color(0xFF3DC5A7);
final _MyLocation = LatLng(37.810575, -122.477174);

const MARKER_SIZE_EXPANDED = 55.0;
const MARKER_SIZE_SHRINK = 38.0;

class AnimetedMarksmap extends StatefulWidget {
  const AnimetedMarksmap({Key? key}) : super(key: key);

  @override
  State<AnimetedMarksmap> createState() => _AnimetedMarksmapState();
}

class _AnimetedMarksmapState extends State<AnimetedMarksmap> {
  final _pageController = PageController();

  // styles map
  String SelectedStyleMap =
      "https://api.mapbox.com/styles/v1/lmariouh/ckvusmwn63aui14o219nsi4kv/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoibG1hcmlvdWgiLCJhIjoiY2tudDJwdHJ1MGE2djJvbjNjc2IyMW9qaSJ9.F6Mpb1w7Gm3xZybgwvFzEw";
  final MonochromeCeleste =
      "https://api.mapbox.com/styles/v1/lmariouh/ckvusmwn63aui14o219nsi4kv/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoibG1hcmlvdWgiLCJhIjoiY2tudDJwdHJ1MGE2djJvbjNjc2IyMW9qaSJ9.F6Mpb1w7Gm3xZybgwvFzEw";
  final Streetsmo =
      "https://api.mapbox.com/styles/v1/lmariouh/ckvusrsgn3al514plc67cn93c/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoibG1hcmlvdWgiLCJhIjoiY2tudDJwdHJ1MGE2djJvbjNjc2IyMW9qaSJ9.F6Mpb1w7Gm3xZybgwvFzEw";
  final Streets =
      "https://api.mapbox.com/styles/v1/lmariouh/ckvw8sr2b4p6e14pllusve2y8/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoibG1hcmlvdWgiLCJhIjoiY2tudDJwdHJ1MGE2djJvbjNjc2IyMW9qaSJ9.F6Mpb1w7Gm3xZybgwvFzEw";

  final zoom = 14.00;
  // usado por logica de animacion
  dynamic _selectedIndex = 0;

  List<Marker> _buildMarkers() {
    final _markerList = <Marker>[];
    for (int i = 0; i < mapMarkers.length; i++) {
      final mapItem = mapMarkers[i];
      _markerList.add(Marker(
          // tamaño real - luego tenemos tamaño animacion
          width: MARKER_SIZE_EXPANDED,
          height: MARKER_SIZE_EXPANDED,
          point: mapItem.location,
          builder: (_) {
            return GestureDetector(
              onTap: () {
                // EN VALIDACION ANIMACION del marker es false por defecto esta varaible
                // no sera false si seleccionamos un marker
                _selectedIndex = i;
                _pageController.animateToPage(i,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.elasticInOut);
                //print('${mapItem.title}');
                setState(() {});
              },
              child: _LocationMarker(
                // va ser  selected igual a si _selectedIndex igual a index
                selected: _selectedIndex == i,
              ),
            );
          }));
    }
    return _markerList;
  }

  @override
  Widget build(BuildContext context) {
    final _markers = _buildMarkers();
    return Scaffold(
      appBar: AppBar(
        // https://www.youtube.com/watch?v=gaKvL88Zws0
        title: const Text('Mohcine map'),

        actions: [
          IconButton(
            icon: const Icon(Icons.add_to_home_screen),
            onPressed: () {
              // TODO: logica cambiat styles con buton - tambie podemos cambiar styles depende del ahora mondial - 00 :00 style night y 6:00 style mornig

              if (SelectedStyleMap == MonochromeCeleste) {
                SelectedStyleMap = Streetsmo;
              } else {
                SelectedStyleMap = MonochromeCeleste;
              }
              // solo llamarlo notifica canbios a escuchadores y redibuja
              setState(() {});
            },
          )
        ],
      ),
      // stack para poner encima
      body: Stack(
        children: [
          FlutterMap(
              options: MapOptions(
                  minZoom: 5, maxZoom: 16, zoom: zoom, center: _MyLocation),
              nonRotatedLayers: [
                TileLayerOptions(
                    urlTemplate: SelectedStyleMap,
                    additionalOptions: {
                      'accessToken': MAPBOX_ACCESS_TOKEN,
                      'id': MAPBOX_STYLE
                    }),
                MarkerLayerOptions(
                  markers: _markers,
                )
              ]),
          Positioned(
            left: 0,
            right: 0,
            bottom: 50,
            height: MediaQuery.of(context).size.height * 0.3,
            child: PageView.builder(
              // controller -paginar - depende de index - desactivado scroll manual
              controller: _pageController,
              // physics: const NeverScrollableScrollPhysics(),
              physics:
                  const BouncingScrollPhysics(), // funcina tanto android como ios
              itemCount: mapMarkers.length,
              itemBuilder: (context, index) {
                final item = mapMarkers[index];

                return _MapItemDetails(
                  mapMarker: item,
                );
              },
            ),
          ),
          Positioned(
            right: 0,
            child: Container(
              // color: Colors.red,
              width: 40,
              height: 100,
              child: Column(
                children: [
                  IconButton(
                    iconSize: 30,
                    icon: const Icon(
                      Icons.zoom_in,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      // TODO: zoom
                      print('+');
                      // solo llamarlo notifica canbios a escuchadores y redibuja
                      setState(() {});
                    },
                  ),
                  IconButton(
                    iconSize: 30,
                    icon: const Icon(
                      Icons.zoom_in,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      // TODO: zoom
                      print('-');
                      // solo llamarlo notifica canbios a escuchadores y redibuja
                      setState(() {});
                    },
                  )
                ],
              ),

              //child:
            ),
          ),
        ],
      ),
    );
  }
}

// markers
class _LocationMarker extends StatelessWidget {
  const _LocationMarker({Key? key, this.selected = false}) : super(key: key);

  final dynamic selected;

  @override
  Widget build(BuildContext context) {
    // print(selected);
    final size = selected ? MARKER_SIZE_EXPANDED : MARKER_SIZE_SHRINK;
    return Center(
        child: AnimatedContainer(
      height: size,
      width: size,
      duration: const Duration(milliseconds: 400),
      child: Image.asset('assets/custom-icon.png'),
    ));
  }
}
// class _MyLocationMarker extends StatelessWidget {
//   const _MyLocationMarker({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 50.0,
//       height: 50.0,
//       decoration: const BoxDecoration(
//         color: MAKER_COLOR,
//         shape: BoxShape.circle,
//       ),
//     );
//   }
// }

class _MapItemDetails extends StatelessWidget {
  final MapMarker mapMarker;
  const _MapItemDetails({Key? key, required this.mapMarker}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _style = TextStyle(
        color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold);
    final _styleAdress = TextStyle(color: Colors.grey[800], fontSize: 20);
    return Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Row(
                // uno lado del otro
                //crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(child: Image.asset(mapMarker.image)),
                  Expanded(
                      child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        mapMarker.title,
                        style: _style,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        mapMarker.address,
                        style: _styleAdress,
                      ),
                      MaterialButton(
                        padding: EdgeInsets.zero,
                        onPressed: () => null,
                        color: MAKER_COLOR,
                        elevation: 6,
                        child: const Text('call',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      )
                    ],
                  )),
                ],
              ),
            ],
          ),
        ));
  }
}
