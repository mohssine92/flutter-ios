import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';

import 'package:latlong2/latlong.dart';

class FullScreenMap extends StatefulWidget {
  @override
  _FullScreenMapState createState() => _FullScreenMapState();
}

class _FullScreenMapState extends State<FullScreenMap> {
  MapController? mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Moshino Map'),
      ),
      body: FlutterMap(
        // mapController :
        options: MapOptions(
          //screenSize: size(),
          center: LatLng(31.62758666856879, -8.031888351204948),
          zoom: 14.0,
          minZoom: 0,
          maxZoom: 14,
          bounds: LatLngBounds(LatLng(31.62758666856879, -8.031888351204948),
              LatLng(35.76826832731924, -5.832412186834678)),
          boundsOptions: FitBoundsOptions(padding: EdgeInsets.all(0.0)),
        ),
        layers: [
          TileLayerOptions(
            urlTemplate:
                "https://api.mapbox.com/styles/v1/lmariouh/ckvusmwn63aui14o219nsi4kv/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoibG1hcmlvdWgiLCJhIjoiY2tudDJwdHJ1MGE2djJvbjNjc2IyMW9qaSJ9.F6Mpb1w7Gm3xZybgwvFzEw",

            additionalOptions: {
              'accessToken':
                  'pk.eyJ1IjoibG1hcmlvdWgiLCJhIjoiY2tudDJwdHJ1MGE2djJvbjNjc2IyMW9qaSJ9.F6Mpb1w7Gm3xZybgwvFzEw',
              'id': 'mapbox.mapbox-streets-v8'
            },
            // attributionBuilder: (_) {
            //   return Text("© OpenStreetMap contributors");
            // },
          ),
          // MarkerLayerOptions(
          //   markers: [
          //     Marker(
          //       width: 80.0,
          //       height: 80.0,
          //       point: LatLng(31.62758666856879, -8.031888351204948),
          //       builder: (ctx) => Container(
          //         child: FlutterLogo(),
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
