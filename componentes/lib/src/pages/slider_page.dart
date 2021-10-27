import 'package:flutter/material.dart';

class SliderPage extends StatefulWidget {
  const SliderPage({Key? key}) : super(key: key);

  @override
  _SliderPageState createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  double _valorSlider = 100.0; // initial state
  // ignore: prefer_final_fields
  bool _bloquearCheck = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Slider'),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 50.0),
        child: Column(
          // del container
          children: <Widget>[
            _crearSlider(),
            _checkBox(),
            _crearSwitch(),
            Expanded(child: _crearImagen()),

            //_crearSwitch(),
            //Expanded(
            //  child: _crearImagen()
            //),
          ],
        ),
      ),
    );
  }

  Widget _crearSlider() {
    return Slider(
      activeColor: Colors.indigoAccent,
      label: 'Tamaño de la imagen',
      divisions: 20,
      value: _valorSlider, // sate del slider
      min: 10.0, //valor minimo y maximo
      max: 900.0, //valor minimo y maximo
      onChanged:
          (_bloquearCheck) // true hace condicion nul , si es nul de desahabilita
              ? null
              : (valor) {
                  //_bloquearCheck = true en checkeado . desahabilita slider

                  setState(() {
                    _valorSlider = valor; // actualizar state y redibujando
                  });
                },
    );
  }

  Widget _checkBox() {
    return CheckboxListTile(
      title: const Text('Bloquear slider'),
      value: _bloquearCheck,
      onChanged: (valor) {
        // valor reves del boolean
        setState(() {
          // clcik valor iùesto de value
          _bloquearCheck = valor!;
        });
      },
    );
  }

  Widget _crearSwitch() {
    return SwitchListTile(
      title: const Text('Bloquear slider'),
      value: _bloquearCheck,
      onChanged: (valor) {
        // clcik valor sale ipuesto de value
        setState(() {
          _bloquearCheck = valor;
        });
      },
    );
  }

  Widget _crearImagen() {
    return Image(
      image: const NetworkImage(
          'http://pngimg.com/uploads/batman/batman_PNG111.png'),
      width: _valorSlider, // valor state manipulado por slider
      fit: BoxFit.contain, // image se ve bien no salga
    );
  }
}
