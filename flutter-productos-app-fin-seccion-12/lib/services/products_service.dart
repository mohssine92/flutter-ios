import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:flutter/material.dart';

import 'dart:io'; // File

import 'package:productos_app/models/models.dart';
import 'package:http/http.dart' as http;

class ProductsService extends ChangeNotifier {
  final String _baseUrl = 'flutter-bc6a8-default-rtdb.firebaseio.com';
  final List<Product> products = [];

  // sera almacenado nueva instancia del index instaciaseleccionada con fin de romper refrencia y no manipular el mismo dentro de products = [];
  late Product selectedProduct;

  // esta instancia es un siglton me trae las manipulacion de la misma instancia  en authservice
  final storage = new FlutterSecureStorage();

  // es un archivo que estamos manteniendo en nuestro servicio lo cual aveces es nulo y aveces no
  File? newPictureFile;

  // saber cuando estoy cargando y cyando no
  bool isLoading = true;
  bool _isSaving = false;

  bool get saving {
    return _isSaving;
  }

  void set saving(bool valor) {
    _isSaving = valor;
    notifyListeners();
  }

  ProductsService() {
    this.loadProducts();
  }

  Future<List<Product>> loadProducts() async {
    this.isLoading = true;
    notifyListeners();

    // token de acceso lo mandamos en este caso como param de url - otro back lo solicitan en headers de request
    final url = Uri.https(_baseUrl, 'products.json',
        {'auth': await storage.read(key: 'token') ?? ''});

    // peticion
    final resp = await http.get(url);

    // TODO: tener en cuenta si la respuesta returna algo dif a lo esperado por tema de token caducado tendremos err en el foreach , debemos cortar proceso y redireccionar hacia login de nuevo es todo
    // formatear la data
    final Map<String, dynamic> productsMap = json.decode(resp.body);

    print(productsMap);

    // pasarla en list
    productsMap.forEach((key, value) {
      print(key);
      print(value);
      final tempProduct = Product.fromMap(value);
      tempProduct.id = key;
      this.products.add(tempProduct);
    });

    this.isLoading = false;
    notifyListeners();

    return this.products; // inecesario
  }

  Future saveOrCreateProduct(Product product) async {
    saving = true;
    notifyListeners();

    if (product.id == null) {
      // Es necesario crear : porque usamos firbase asi al recupera masajeamos la llave como id prop en el objeto
      await this.createProduct(product);
    } else {
      // Actualizar
      await this.updateProduct(product);
    }

    saving = false;
    notifyListeners();
  }

  Future<String> updateProduct(Product product) async {
    // actualizar db
    final url = Uri.https(_baseUrl, 'products/${product.id}.json',
        {'auth': await storage.read(key: 'token') ?? ''});
    final resp = await http.put(url, body: product.toJson());
    // ignore: unused_local_variable
    final decodedData = resp.body;

    //print(decodedData);

    // Actualizar el listado de productos nuestra memoria centralizada
    // porque actualizamos y para actualizar el producto deberia estar con su id el mamoria list
    final index =
        this.products.indexWhere((element) => element.id == product.id);
    this.products[index] = product; // impactar la data en la lista memoria

    return product.id!;
  }

  Future<String> createProduct(Product product) async {
    // save en db de firebase api
    final url = Uri.https(_baseUrl, 'products.json',
        {'auth': await storage.read(key: 'token') ?? ''});
    final resp = await http.post(url, body: product.toJson());
    final decodedData = json.decode(resp.body);

    product.id = decodedData['name'];

    this.products.add(product);

    return product.id!;
  }

  void updateSelectedProductImage(String path) {
    // occupamos para redibujar imagen
    this.selectedProduct.picture = path;

    // crear file img basado en url de img en dispositivo - file a subir via post - http -> cloudinary
    this.newPictureFile = File.fromUri(Uri(path: path));

    //print(this.newPictureFile);

    notifyListeners();
  }

  // proceso subir una imagen en este caso a servicio nube
  // lo disparo al dar clcik save button
  Future<String?> uploadImage() async {
    // despues de pasar la barrera - que na va ser nul -asi le avisara ! debe confiar en me
    if (this.newPictureFile == null) return null;

    // con fin redibujar loading widget
    this.saving = true;
    notifyListeners();

    // podemos hacer mediamte https , pero lo hacemos de otra forma que es parce
    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/dzrbdobpn/image/upload?upload_preset=flutter');

    // post , put , get
    final imageUploadRequest = http.MultipartRequest('POST', url);

    // archivo a subir img - 'file' este nombre es importante escribirlo tal cual espera cloudinary o back nodejs o storage
    final file =
        await http.MultipartFile.fromPath('file', newPictureFile!.path);

    // adjuntar archivo a la configuracion de la  peticion http
    imageUploadRequest.files.add(file);

    // disparar la peticion a coudinary
    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('algo salio mal');
      print(resp.body);
      return 'error';
    }

    // resetearfile indicar que lo subi a la nube - y tambien no permite hacer proceso de subir a cloudibary en caso de update sin selecionar nuevo archivo
    this.newPictureFile = null;

    // fron stringifyjson to map
    final decodedData = json.decode(resp.body);
    print(decodedData['secure_url']);
    return decodedData['secure_url'];
  }
}

// porque ChangeNotifier ?? _ porque voy a implementar provider ,  y provider m ayuda a gestionar de manera muy facil

// debemos asegura que el servicio este instanciado glbalmete o solo cuando alguien entra a pantalla de productos - todos queda a nuestra decrecion
// ventaja tenemos que provider nos ofrece lazy es decir solo cuando se necesita la instancia se crea , eso nos da ventaja de implementarlo de manera global
