// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';

// va ser un satatefullwidget porque necesito manejar la informacion de las cajas de texto y con este informacion necesito jugar con la informacion

class InputPage extends StatefulWidget {
  const InputPage({Key? key}) : super(key: key);

  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  String _nombre = '';
  String _email = '';
  String _fecha = '';

  // ignore: prefer_final_fields
  String _opcionSeleccionada = 'Volar';

  // ignore: prefer_final_fields
  List<String> _poderes = ['Volar', 'Rayos X', 'Super Aliento', 'Super Fuerza'];

  // esta prop no da referencia a un elemento para añadirloe valor etc ...
  // ignore: prefer_final_fields
  TextEditingController _inputFieldDateController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inputs de texto'),
      ),
      body: ListView(
        // usualmente desplegue el tecalado por lo cual necesito hacer scroll :
        padding: const EdgeInsets.symmetric(
            horizontal: 10.0, vertical: 20.0), // al children en este caso
        children: <Widget>[
          _crearInput(),
          const Divider(),
          _crearEmail(),
          const Divider(),
          _crearPassword(),
          const Divider(),
          _crearFecha(context),
          const Divider(),
          _crearDropdown(),
          const Divider(),
          _crearPersona()
        ],
      ),
    );
  }

  Widget _crearInput() {
    // return element input widget

    return TextField(
      // imput independiente , formFiels tarabaja como formnulario mejor para hacer validaciones
      // autofocus: true, // focuas input automaticlly open teclado
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          //78 perzobalizar input
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          counter: Text('Letras ${_nombre.length} '),
          hintText: 'Nombre de la persona',
          labelText: 'Nombre',
          helperText: 'Sólo es el nombre',
          suffixIcon: const Icon(Icons.accessibility),
          icon: const Icon(Icons.account_circle)),
      onChanged: (valor) {
        // necesito captar cambios en el input
        setState(() {
          _nombre = valor;
        }); // cambia estado de _nombre y redibujar el widget con los nuevos cambios
      },
    );
  }

  Widget _crearEmail() {
    return TextField(
        keyboardType: TextInputType.emailAddress, //me desplega teclado con @
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            hintText: 'Email',
            labelText: 'Email',
            suffixIcon: const Icon(Icons.alternate_email),
            icon: const Icon(Icons.email)),
        onChanged: (valor) => setState(() {
              _email = valor;
            }));
  }

  Widget _crearPassword() {
    return TextField(
        obscureText: true, // occultar letra passwod
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            hintText: 'Password',
            labelText: 'Password',
            suffixIcon: const Icon(Icons.lock_open),
            icon: const Icon(Icons.lock)),
        onChanged: (valor) => setState(() {
              _email = valor;
            }));
  }

  Widget _crearFecha(BuildContext context) {
    return TextField(
      enableInteractiveSelection: false, // desahinilar copy
      controller:
          _inputFieldDateController, // _inputFieldDateController me relaciona con el input para hacerle algo
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          hintText: 'Fecha de nacimiento',
          labelText: 'Fecha de nacimiento',
          suffixIcon: const Icon(Icons.perm_contact_calendar),
          icon: const Icon(Icons.calendar_today)),
      onTap: () {
        // aqui no uso onChange() - uso onTap()

        FocusScope.of(context).requestFocus(
            new FocusNode()); // evit foco - no desplegar teclado del dispositivo - occupamos desplegable para seleccion de fechas
        _selectDate(
            context); // need crear algo dinamico en pantall - y fluuter need saber posicion colocarle
      },
    );
  }

  _selectDate(BuildContext context) async {
    // tipo DateTime sirve para almacenar una fecha
    // ignore: unused_local_variable
    DateTime? picked = await showDatePicker(
        // tipado sirve para almazenar fechas seleccionada
        context: context, // paraque sepa en que  lugar colocar ese modal
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2018),
        lastDate: new DateTime(2025),
        locale: const Locale('fr',
            'FR')); // cambiar fecha del desplegable seleecionar fecha ver main

    if (picked != null) {
      // es decir el objeto tiene fecha seleccionada
      // entnces coloco valor de de la fecha seleccionada a la caja de texto y redebujo
      setState(() {
        _fecha = picked.toString();
        _inputFieldDateController.text =
            _fecha; // ya esta relacionado al input asi le meto texto
      }); // redibujar
    }
  }

  List<DropdownMenuItem<String>> getOpcionesDropdown() {
    // la tarea aqui es recibir lista de strings y returnar lista de DropdownMenuItem()(s)
    List<DropdownMenuItem<String>> lista = [];

    for (var poder in _poderes) {
      lista.add(DropdownMenuItem(
        child: Text(poder),
        value: poder,
      ));
    }

    return lista;
  }

  Widget _crearDropdown() {
    // seelect
    return Row(
      // uno lado del otro
      children: <Widget>[
        // es del Row
        const Icon(Icons.select_all),
        const SizedBox(width: 30.0), // espacio entre
        Expanded(
          // todo ancho posible selecinable
          child: DropdownButton(
            //
            value: _opcionSeleccionada, // valor seleccionado a mostrar en input
            items: getOpcionesDropdown(), // lista a desplegar
            onChanged: (opt) {
              setState(() {
                _opcionSeleccionada = opt.toString();
              });
            },
          ),
        )
      ],
    );
  }

  Widget _crearPersona() {
    // elemento widget muestra cambio de state on real time

    return ListTile(
      title: Text('Nombre es: $_nombre'),
      subtitle: Text('Email: $_email'),
      trailing: Text(_opcionSeleccionada),
    );
  }
} // hay varias formas de hacer scrol no solamente con listView() , haste el momento hemos visto solamente listView()
