import 'package:flutter/material.dart';

// como alerta

class NotificationsService {
  // sirve para mantener ref a un widget en particular muy importante que es mi material app
  static GlobalKey<ScaffoldMessengerState> messengerKey =
      new GlobalKey<ScaffoldMessengerState>();

  static showSnackbar(String message) {
    final snackBar = new SnackBar(
      content:
          Text(message, style: TextStyle(color: Colors.white, fontSize: 20)),
    );

    messengerKey.currentState!.showSnackBar(snackBar);
  }
}
