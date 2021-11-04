import 'dart:io'; // file

import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  final String? url;

  const ProductImage({Key? key, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Container(
        decoration: _buildBoxDecoration(),
        width: double.infinity,
        height: 450,
        child: Opacity(
          opacity: 0.9,
          //  ClipRRect para recortar image . respetar border del decoracion del container
          child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(45), topRight: Radius.circular(45)),
              child: getImage(url)),
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
          // container de img es de color - si image no tiene fondo de container tomara este color especificado
          color: Colors.black,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(45), topRight: Radius.circular(45)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: Offset(0, 5))
          ]);

  Widget getImage(String? picture) {
    //ternario widget
    if (picture == null)
      return Image(
        image: AssetImage('assets/no-image.png'),
        fit: BoxFit.cover,
      );

    // recuerda tiene que empezar con http tambien implica https
    if (picture.startsWith('http'))
      return FadeInImage(
        // only https: - cloudinary etc ...
        image: NetworkImage(this.url!),
        placeholder: AssetImage('assets/jar-loading.gif'),
        fit: BoxFit.cover,
      );

    //
    return Image.file(
      // picture se que es path fisico en mi dispositivo
      File(picture),
      fit: BoxFit.cover,
    );
  }
}
