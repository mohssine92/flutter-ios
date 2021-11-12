import 'package:flutter/material.dart';

//import 'package:mapbox/src/views/fullscreenmap.dart';
import 'package:mapbox/src/views/fullscreenmap1.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(body: AnimetedMarksmap()),
    );
  }
}
