import 'package:flutter/material.dart';

import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  final String _baseUrl = 'identitytoolkit.googleapis.com';

  // esto es el token de acceso al api de firebase
  final String _firebaseToken = 'AIzaSyANa4QvKHlcFR7ZxkzwMHHU0OxFadFeZRI';

  final storage = new FlutterSecureStorage();

  // Si retornamos algo, es un error, si no, todo bien!
  Future<String?> createUser(String email, String password) async {
    // recuerda al mandar peticion post - mandamos como mapa
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken	': true
    };

    final url = Uri.https(_baseUrl, '/v1/accounts:signUp', {
      // parte de argumentos de peticion
      'key': _firebaseToken
    });

    final resp = await http.post(url, body: json.encode(authData));
    // json strigify top map
    final Map<String, dynamic> decodedResp = json.decode(resp.body);

    // siempre obtenemos respuesta de exito o err
    // print(decodedResp);

    if (decodedResp.containsKey('idToken')) {
      // verifica map si contaga tal llave - guardar token storage
      // Token hay que guardarlo en un lugar seguro
      await storage.write(key: 'token', value: decodedResp['idToken']);
      //decodedResp['idToken'];
      return null;
    } else {
      // caso de err
      return decodedResp['error']['message'];
    }
  }

  Future<String?> login(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final url = Uri.https(
        _baseUrl, '/v1/accounts:signInWithPassword', {'key': _firebaseToken});

    final resp = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodedResp = json.decode(resp.body);

    if (decodedResp.containsKey('idToken')) {
      // save it on storage instance
      await storage.write(key: 'token', value: decodedResp['idToken']);

      return null;
    } else {
      return decodedResp['error']['message'];
    }
  }

  Future logout() async {
    await storage.delete(key: 'token');
    return;
  }

  // puedo returnar string? pero no porque este future estara sujeto a un FutureBuilder y dara err , por eso returna string de todo modo
  Future<String> readToken() async {
    return await storage.read(key: 'token') ?? '';
  }
}

// manejamos las peticiones http de autenticacion de manera separada

// NB: los servicios son lugares donde esta centralizada la informacion global de mi app , principalmente se encargan de destrubuir la informacion y hacer peticiones http
