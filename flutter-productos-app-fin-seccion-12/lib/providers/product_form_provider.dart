import 'package:flutter/material.dart';

import 'package:productos_app/models/models.dart';

class ProductFormProvider extends ChangeNotifier {
  // mantener refrerencia al formulario
  // ref  a este Formkey puede hacer validacion desde aqui
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  // para alojar producto seleccionado
  Product product;

  // importantisimo que sea una copia si no hacemos manipulacione por refrencia
  ProductFormProvider(this.product);

  updateAvailability(bool value) {
    print(value);
    this.product.available = value;
    notifyListeners();
  }

  bool isValidForm() {
    print(product.name);
    print(product.price);
    print(product.available);

    return formKey.currentState?.validate() ?? false;
    // si es nul ?? regresa false , ? si aun no esta asignado a algun widget
    //normalmente regresa boolean en funcion de validacion del form kyeado
  }
}
