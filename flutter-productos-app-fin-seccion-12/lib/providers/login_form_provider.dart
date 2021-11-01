import 'package:flutter/material.dart';

class LoginFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<
      FormState>(); // prop de tipo controla form internamentre verifica la validacion dada  en los inputs

  String email = '';
  String password = '';

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool isValidForm() {
    print(formKey.currentState
        ?.validate()); // recuerda se ejecutan la validaciones asi por eso salen los textos en inputes respectivos

    print('$email - $password');

    return formKey.currentState?.validate() ??
        false; // pude ser null , si esta asociado a un form , form valid regresa true sino ?? false
  }
}
