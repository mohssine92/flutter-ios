import 'package:flutter/material.dart';

import 'package:productos_app/services/services.dart';

import 'package:provider/provider.dart';
import 'package:productos_app/providers/login_form_provider.dart';

import 'package:productos_app/ui/input_decorations.dart';
import 'package:productos_app/widgets/widgets.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // my custom widget - recibe prop child - fondo screen ,
        body: AuthBackground(
            // permite hacer scroll si sus hijos pasan tamano que tiene el dispositivo
            child: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
              height: 250), // fin que mis widgets van apareciendo un poco abajo

          CardContainer(
              // custom widget
              child: Column(
            children: [
              SizedBox(height: 10),
              Text('Crear cuenta',
                  style: Theme.of(context).textTheme.headline4),
              SizedBox(height: 30),
              ChangeNotifierProvider(
                  // similar a multiprovider ,pero valido solo cando tenemos un provider
                  //este provider solo le imporat al _loginForm
                  create: (_) => LoginFormProvider(),
                  child: _LoginForm() // formulario
                  )
            ],
          )),

          SizedBox(height: 50),
          TextButton(
              onPressed: () => Navigator.pushReplacementNamed(context, 'login'),
              style: ButtonStyle(
                  overlayColor:
                      MaterialStateProperty.all(Colors.indigo.withOpacity(0.1)),
                  shape: MaterialStateProperty.all(StadiumBorder())),
              child: Text(
                '¿Ya tienes una cuenta?',
                style: TextStyle(fontSize: 18, color: Colors.black87),
              )),
          SizedBox(height: 50),

          // cando sale teclado tenemos espacio isuficiente alli hacemos scroll
        ],
      ),
    )));
  }
}

class _LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // buscar instancia provider
    final loginForm = Provider.of<LoginFormProvider>(context);

    return Container(
      // siempre container si por si acaso quiero luego estilizar
      child: Form(
        // form widget va tener referencia al estado completo que tiene sus widgets internos
        key: loginForm
            .formKey, // key del form nos va decir si el form y todos sus campos pasaron la validacion respectivas o no
        autovalidateMode: AutovalidateMode
            .onUserInteraction, // dispara validator , hay varios escenarios para disparar el mismo

        child: Column(
          // uno bajo de otro
          children: [
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                  // ui - custom class prop static , recibe estos props
                  hintText: 'john.doe@gmail.com',
                  labelText: 'Correo electrónico',
                  prefixIcon: Icons.alternate_email_rounded),
              onChanged: (value) => loginForm.email = value,
              validator: (value) {
                // validacion respectiva

                String pattern =
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp = new RegExp(pattern);

                return regExp.hasMatch(value ?? '')
                    ? null // conciderado la validacion paso
                    : 'El valor ingresado no luce como un correo';
              },
            ),
            SizedBox(height: 30),
            TextFormField(
              autocorrect: false,
              obscureText: true, // invisible eclas password
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                  hintText: '*****',
                  labelText: 'Contraseña',
                  prefixIcon: Icons.lock_outline),
              onChanged: (value) => loginForm.password = value,
              validator: (value) {
                // validacion respectiva al momento de escribir

                return (value != null && value.length >= 6)
                    ? null
                    : 'La contraseña debe de ser de 6 caracteres';
              },
            ),
            SizedBox(height: 30),
            MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                disabledColor: Colors.grey,
                elevation: 0,
                color: Colors.deepPurple,
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                    child: Text(
                      loginForm.isLoading ? 'Espere' : 'Ingresar',
                      style: TextStyle(color: Colors.white),
                    )),
                onPressed: loginForm.isLoading
                    ? null
                    : () async {
                        // para desahabilatr button onPress tiene que ser nul

                        FocusScope.of(context).unfocus(); // quitar teclado
                        // buscar servicio en el context - false no redibuje - estoy dentro de una funcion no build da err
                        final authService =
                            Provider.of<AuthService>(context, listen: false);

                        if (!loginForm.isValidForm())
                          return; // forezar validacion al dar click boton

                        loginForm.isLoading = true; // ster - notifu - redibuja

                        //await Future.delayed(Duration(seconds: 2));

                        // TODO:  aqui occupamos algun backend para creacion  de user en algun db
                        final String? errorMessage = await authService
                            .createUser(loginForm.email, loginForm.password);

                        print(errorMessage);
                        if (errorMessage == null) {
                          // segun logica es nul - autenticacion exitosa
                          Navigator.pushReplacementNamed(context, 'home');
                        } else {
                          // TODO: mostrar error en pantalla
                          print(errorMessage);
                          NotificationsService.showSnackbar(errorMessage);
                          loginForm.isLoading = false;
                        }
                      })
          ],
        ),
      ),
    );
  }
}
