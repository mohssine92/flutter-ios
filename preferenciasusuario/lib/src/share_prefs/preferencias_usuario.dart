import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario {
  // crear instancia
  static final PreferenciasUsuario _instancia = PreferenciasUsuario._internal();

  // constructor normal , cuando se ejecuta returna instancia ya tengo  creada arriba ,
  // permite regresar la misma instancia de esta clase .
  // no importa en cuantos lugares hago new siempre sera regresada la msma instancia
  factory PreferenciasUsuario() {
    return _instancia;
  }

  // metodo a llamar para creae una instancia
  PreferenciasUsuario._internal();

  late SharedPreferences
      _prefs; // tipo para grabar en storage , late es decir  cunado lo usas tendra valor

  // instancia de nuestro espacio de memoria
  initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // GET y SET del Genero
  int get genero {
    return _prefs.getInt('genero') ??
        1; // si no existe genero por defecto sera 1 - caso de primera carga de la app en un dispositivo
  }

  set genero(int value) {
    _prefs.setInt('genero', value);
  }

  // GET y SET del _colorSecundario
  bool get colorSecundario {
    return _prefs.getBool('colorSecundario') ?? false;
  }

  set colorSecundario(bool value) {
    _prefs.setBool('colorSecundario', value);
  }

  // GET y SET del nombreUsuario
  String get nombreUsuario {
    return _prefs.getString('nombreUsuario') ?? '';
    // primer cargar en un dispositivo va ser nul este getter le asignas string vacio
  }

  set nombreUsuario(String value) {
    _prefs.setString('nombreUsuario', value);
  }

  // GET y SET de la última página
  String get ultimaPagina {
    return _prefs.getString('ultimaPagina') ?? 'home';
  }

  set ultimaPagina(String value) {
    _prefs.setString('ultimaPagina', value);
  }
}

// podemos grabar : token , id user , notificaciones , tema de la app , cosas por el estilo
