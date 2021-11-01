import 'dart:async';

class Debouncer<T> {
  // generic es decir voy a recibir lagun tipo de data al momento de crear la instancia del mismo
  Debouncer(
      {required this.duration, //  cantidad de tiempo a espara antes de emitir un valor
      this.onValue //un meto que voy a dispara cuando tenga un valor desde afuera , todavia no se lo que va hacer la funcion pero la defino porque se que sera una fucnion
      });

  final Duration duration;

  void Function(T value)?
      onValue; // es opcional porque la disparo un poco despues sino el construcctor la va a requerir al momento de crear la instancia

  T? _value;
  Timer? _timer;

  T get value => _value!;

  set value(T val) {
    //setear valor a geter en la instacia
    _value = val;
    _timer?.cancel(); // de abajo cuando se crea por primer vez
    _timer = Timer(
        duration,
        () => onValue!(
            _value!)); // timer funcion de controler vien por parte de dart - si rl timer cumple duration especificado mando allamar el callback
  }
}

// dbouncer no es mas este escucuchando teclas , hasta que la persona deja de escribir alli la persona me va dispara un valor .
