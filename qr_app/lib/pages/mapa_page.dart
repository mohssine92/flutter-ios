import 'package:flutter/material.dart';

import 'dart:async'; // _controlelr

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:qr_app/providers/db_provider.dart';

class MapaPage extends StatefulWidget {
  const MapaPage({Key? key}) : super(key: key);

  @override
  State<MapaPage> createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  // ignore: prefer_final_fields
  Completer<GoogleMapController> _controller = Completer();
  MapType mapType = MapType.normal;

  @override
  Widget build(BuildContext context) {
    // recibir arg
    final ScanModel scan =
        ModalRoute.of(context)!.settings.arguments as ScanModel;

    // camara initial position
    final CameraPosition puntoInitial = CameraPosition(
        target: scan.getLatLng(), //LatLng(37.42796133580664, -122.085749655962)
        zoom: 17.5,
        tilt: 50);

    // Marcadores
    // ignore: prefer_collection_literals
    Set<Marker> markers = Set<Marker>();

    markers.add(Marker(
        // ignore: prefer_const_constructors
        markerId: MarkerId('geo-location'), // tiene que ser unico el nombre
        position: scan.getLatLng()));

    // markers.add(new Marker(
    //     markerId: MarkerId('geo-location'),
    //     position: LatLng(
    //         24.448439, 54.390324))); // segunda instancia es mas mas marcadores

    return Scaffold(
      appBar: AppBar(
        title: const Text('Maps'),
        actions: [
          IconButton(
              icon: const Icon(Icons.location_disabled),
              onPressed: () async {
                final GoogleMapController controller = await _controller
                    .future; // wating que se resuelva controller - pude ser que se presione antes que este lista la mapa
                controller.animateCamera(CameraUpdate.newCameraPosition(
                    puntoInitial
                    /* CameraPosition(
                    target: scan.getLatLng(),
                    zoom: 17.5,
                    tilt: 50
                  ) */
                    ));
              })
        ],
      ),
      body: GoogleMap(
        myLocationButtonEnabled: false,
        //zoomControlsEnabled: true,
        mapType: mapType,
        markers: markers,
        initialCameraPosition: puntoInitial,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
          // si navigamos entre pantallas implemenatan floatingActionButon flutter hace un animacion por nosotros
          child: Icon(Icons.layers),
          onPressed: () {
            if (mapType == MapType.normal) {
              mapType = MapType.satellite;
            } else {
              mapType = MapType.normal;
            }

            setState(
                () {}); // stateful widget maneja state , dispara , redibujar sateful widget afer update state
          }),
    );
  }
}
