import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:providers/src/pages/tab1_page.dart';
import 'package:providers/src/pages/tab2_page.dart';

class TabsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      // injectar este provider en el context : aqui creacion de instancia de clase - aqui se ejecuta constructor y sus requerimientos
      create: (_) => _NavegacionModel(),
      child: Scaffold(
        body: _paginas(),
        bottomNavigationBar: _Navegacion(),
      ),
    );
  }
}

class _Navegacion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // obtencion de la instancia creada del provider desde el context - recien instanciada y injectada en el context de la app  desde un nivel superior
    // obtencion como si fuera un siglton desde cualquier lugar bajo nivel permitido logicamente
    final navegacionModel = Provider.of<_NavegacionModel>(context);

    // requir minimo 2 botones
    return BottomNavigationBar(
        currentIndex: navegacionModel.paginaActual,
        onTap: (i) => navegacionModel.paginaActual = i, // seter - redibuja
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), title: Text('Para ti')),
          BottomNavigationBarItem(
              icon: Icon(Icons.public), title: Text('Encabezados')),
        ]);
  }
}

// mostarar pagina respectiva
class _paginas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navegacionModel = Provider.of<_NavegacionModel>(context);
    return Center(
      child: PageView(
        //physics hace effect tanto android como ios que hay scroll
        // physics: BouncingScrollPhysics(),
        // es scrol pero se restringe al dedo - lo permtemos solo con butones usando privider
        // recuerda navegacionModel.pageController : muestra container en pantalla usando indixes recibido - para mostracion de un index container de la colccion
        controller: navegacionModel.pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Tab1Page(),
          // container n 2
          Tab2Page()
        ],
      ),
    );
  }
}

// with : es mesclar modelos -
// conciderada tambien un siglton - gracias al provider
class _NavegacionModel with ChangeNotifier {
  // si preguntas porque usamos setter y gett - porque al setear debo redibujar . al reves si uso prop publica no tengo como disparar notifyListeners(); que me ofrece provider
  int _paginaActual = 0;
  final PageController _pageController = PageController();

  // exponer mi prop privada a cualquier otro lugar , donde estoy trabajando con esta instancia
  int get paginaActual => _paginaActual;

  set paginaActual(int valor) {
    _paginaActual = valor;

    _pageController.animateToPage(valor,
        duration: const Duration(milliseconds: 250), curve: Curves.easeOut);

    notifyListeners();
    // si quiero implementar lo mismo de redibujar usando un singlton y no un provider voy a tener necesidad de trabajar con FutureBuilder o StreamBuilder
  }

  PageController get pageController => _pageController;
}
