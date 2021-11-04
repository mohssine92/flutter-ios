import 'package:flutter/material.dart';
// FilteringTextInputFormatter
import 'package:flutter/services.dart';

import 'package:productos_app/widgets/widgets.dart';

import 'package:productos_app/ui/input_decorations.dart';

import 'package:provider/provider.dart';
import 'package:productos_app/services/services.dart';

import 'package:productos_app/providers/product_form_provider.dart';

import 'package:image_picker/image_picker.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // obtener servio desde el context
    final productService = Provider.of<ProductsService>(context);

    // hemos extraedo scafold en un widget con fin de integrar ProductFormProvider en el context por que le ineteresa solo a esta scafold

    return ChangeNotifierProvider(
        create: (_) => ProductFormProvider(productService.selectedProduct),
        child: _ProductScreenBody(productService: productService));
  }
}

class _ProductScreenBody extends StatelessWidget {
  const _ProductScreenBody({
    Key? key,
    required this.productService,
  }) : super(key: key);

  final ProductsService productService;

  @override
  Widget build(BuildContext context) {
    // obtener provider del context validacion form
    final productForm = Provider.of<ProductFormProvider>(context);

    // GestureDetector //con fin  dectar click en pantalla cierra teclado abierto
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        // vamos a tener forms y mas elementos - desplegar teclado puede esconder elementos - usamos scroll
        body: SingleChildScrollView(
          child: Center(
              // col permite colocarelementos bajo de otro
              child: Column(
            children: [
              // tarjeta encima de ella dos butones  - stack me permie poner elemento ecima de otros
              Stack(
                children: [
                  ProductImage(url: productService.selectedProduct.picture),
                  // posicionar fija
                  Positioned(
                      top: 60,
                      left: 20,
                      child: IconButton(
                        onPressed: () =>
                            Navigator.of(context).pop(), // salir de pantalla
                        icon: Icon(Icons.arrow_back_ios_new,
                            size: 40, color: Colors.white),
                      )),

                  Positioned(
                      top: 60,
                      right: 20,
                      child: IconButton(
                        onPressed: () async {
                          final picker = new ImagePicker();
                          //archivo seleccionado - resource tenemos dos tipos camara o galery
                          final XFile? pickedFile = await picker.pickImage(
                              //source: ImageSource.gallery,
                              source: ImageSource.camera,
                              imageQuality: 100);

                          if (pickedFile == null) {
                            print('No seleccionó nada');
                            return;
                          }

                          // path  del img en el dispositivo fesico o simulador
                          //print(pickedFile.path);

                          productService
                              .updateSelectedProductImage(pickedFile.path);
                        },
                        icon: Icon(Icons.camera_alt_outlined,
                            size: 40, color: Colors.white),
                      )),
                  Positioned(
                      top: 100,
                      right: 20,
                      child: IconButton(
                        onPressed: () async {
                          final picker = new ImagePicker();
                          //archivo seleccionado - resource tenemos dos tipos camara o galery
                          final XFile? pickedFile = await picker.pickImage(
                              source: ImageSource.gallery,
                              //source: ImageSource.camera,
                              imageQuality: 100);

                          if (pickedFile == null) {
                            print('No seleccionó nada');
                            return;
                          }

                          // path  del img en el dispositivo fesico o simulador
                          //print(pickedFile.path);

                          productService
                              .updateSelectedProductImage(pickedFile.path);
                        },
                        icon: Icon(Icons.add_a_photo_sharp,
                            size: 40, color: Colors.white),
                      ))
                ],
              ),
              _ProductForm(),

              // tenemos scrool implementado - este espacio nos ofrece espacio donde poner el dedo para hacer scrol de abajo
              SizedBox(height: 100),
            ],
          )),
        ),
        // posicionar floatingActionButton un poquito mas abajo - nos da un poco de animacion en este caso
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: FloatingActionButton(
          // ternario a prop de widget
          child: productService.isSaving
              ? CircularProgressIndicator(color: Colors.white)
              : Icon(Icons.save_outlined),
          //cuando da click a save saving debe ser false
          onPressed: productService.isSaving
              ? null // paraque ne se puede dar clcik en button
              : () async {
                  if (!productForm.isValidForm()) return;

                  final String? imageUrl = await productService.uploadImage();

                  //  si existe asignar url https de cloudinary al product object salvado en breve en firebase
                  if (imageUrl != null) productForm.product.picture = imageUrl;

                  await productService.saveOrCreateProduct(productForm.product);
                },
        ),
      ),
    );
  }
}

class _ProductForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);
    // importante sabras que product es una copia  su manipulacion no afecta la memoria de nuestro class service
    final product = productForm.product;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10), // <-->
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: _buildBoxDecoration(),
        child: Form(
            //  controla validacion global del form usaulmente actua al momento de click save
            key: productForm.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                SizedBox(height: 10),
                TextFormField(
                  initialValue: product.name,
                  onChanged: (value) => product.name = value,
                  validator: (value) {
                    if (value == null || value.length < 1)
                      return 'El nombre es obligatorio';
                  },
                  // custom class
                  decoration: InputDecorations.authInputDecoration(
                      hintText: 'Nombre del producto', labelText: 'Nombre:'),
                ),
                SizedBox(height: 30),
                TextFormField(
                  // porque llega tipo nuber y initialValue recibe string
                  initialValue: '${product.price}',
                  //en cual poner dif reglas
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        // expresion regular poder escribir a loque coincida a ...
                        RegExp(r'^(\d+)?\.?\d{0,2}'))
                  ],
                  // number no uso porque no puermite punto
                  keyboardType: TextInputType.visiblePassword,
                  // recuerda cajas de textos regresan string no numeros
                  onChanged: (value) => {
                    if (double.tryParse(value) == null)
                      {
                        // nul no se puede parsear por eso ...
                        product.price = 0,
                      }
                    else
                      {
                        product.price = double.parse(value),
                      }
                  },

                  // custom class
                  decoration: InputDecorations.authInputDecoration(
                      hintText: '\$150', labelText: 'Precio'),
                ),
                SizedBox(height: 30),
                // adaptivo segun plataform en que esta corriendo android o ios
                SwitchListTile.adaptive(
                    value: product.available,
                    title: Text('Disponible'),
                    activeColor: Colors.indigo,
                    // (){} , value emitida por onChanged pasa como arg en updateAvailability function
                    onChanged: productForm.updateAvailability),
              ],
            )),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: Offset(0, 5),
                blurRadius: 5)
          ]);
}
