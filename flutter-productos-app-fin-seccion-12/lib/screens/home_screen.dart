import 'package:flutter/material.dart';

import 'package:productos_app/models/models.dart';

import 'package:productos_app/screens/screens.dart';

import 'package:provider/provider.dart';
import 'package:productos_app/services/services.dart';

import 'package:productos_app/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Leer ProductsService - en este instante esta isntanciado
    final productsService = Provider.of<ProductsService>(context);
    final authService = Provider.of<AuthService>(context, listen: false);

    // loading scafold - parece momento decarga .... services - firebase
    if (productsService.isLoading) return LoadingScreen();

    return GestureDetector(
      onTap: () => () {
        print('clk');
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Productos'),
          leading: IconButton(
            icon: Icon(Icons.login_outlined),
            onPressed: () {
              authService.logout();
              Navigator.pushReplacementNamed(context, 'login');
            },
          ),
        ),
        // ventaja de ListView.builder es peresoso - va creando widgets conforme estan entrando a la pantalla - es util si tenemos 1000 widgets , mejor que si tenemos listvien normal
        body: ListView.builder(
            itemCount: productsService.products.length,
            itemBuilder: (BuildContext context, int index) => GestureDetector(
                onTap: () {
                  // se rompre ref , porque copy lo que hace toma la instancia y crea nueva instancia usando la misma , asi no sera afectada list de products . !! importante
                  // asi puedo hacer cualqueir modificacion en selectedProduct en no afectara el objeto original obtenido de db elmacenado en memoria de la class .
                  productsService.selectedProduct =
                      productsService.products[index].copy();
                  Navigator.pushNamed(context, 'product');
                },
                child: ProductCard(
                  // products es list donde hemos pushado
                  product: productsService.products[index],
                ))),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            // porque instancia de Product ?  - porque scrren al que redericcionamos requiere el objeto a rellenar - si vamos nulo  da err - basicamente la mismo scrren de edicion
            // recuerda que mantenemos la misma instancia de productsService - a lo largo de la app
            productsService.selectedProduct =
                new Product(available: false, name: '', price: 0);

            Navigator.pushNamed(context, 'product');
          },
        ),
      ),
    );
  }
}
