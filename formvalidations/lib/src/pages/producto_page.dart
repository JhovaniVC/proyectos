//@dart=2.9
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:formvalidations/src/bloc/provider.dart';

import 'package:formvalidations/src/models/producto_model.dart';
import 'package:formvalidations/src/utils/utils.dart' as utils;
import 'package:image_picker/image_picker.dart';


class ProductoPage extends StatefulWidget {
  @override
  State<ProductoPage> createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {

  final formKey = GlobalKey<FormState>();
  final scaffoldKey =GlobalKey<ScaffoldState>();
 
  ProductosBloc productosBloc;  
  ProductoModel producto = new ProductoModel();
  bool _guardando = false;
  File foto;

  @override
  Widget build(BuildContext context) {

      productosBloc = Provider.productosBloc(context);

      final ProductoModel prodData = ModalRoute.of(context).settings.arguments;
      if (prodData !=null ) {
        producto = prodData;
      }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('Producto'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: _seleccionarFoto,
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: _tomarFoto,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child:Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey ,
            child: Column(
              children: [
                _mostrarFoto(),
                _crearNombre(),
                _crearPrecio(),
                _crearDisponible(),
                _crearBoton(),

              ],
            ),
            ),
        ),
        ),
    );

  }

    Widget _crearNombre(){
      return TextFormField(
        initialValue: producto.titulo,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          label: Text('Producto')
        ),
        onSaved: (value) => producto.titulo = value,
        validator: (value){
          if(value.length < 3 ){
            return 'Ingrese el nombre del producto';
          }else{
            return null;
          }
        },
      );
    }

    Widget _crearPrecio(){

      return TextFormField(
        initialValue: producto.valor.toString(),
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(
          label: Text('Precio')
        ),
        onSaved: (value) => producto.valor = double.parse(value),
        validator: (value){
          
          if(utils.isNumeric(value)){
            return null;
          }else {
            return 'Sólo números';
          }

        },
      );
    }

    Widget _crearDisponible (){
      return SwitchListTile(
        value: producto.disponible,
        title: Text('Disponible'),
        activeColor: Colors.deepPurple,
        onChanged: (value) => setState((){
          producto.disponible = value ;
        }),
        );
    }

  Widget _crearBoton(){
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
        ),
        backgroundColor: Colors.deepPurple
      ), 
     label: Text('Guardar'),
     icon: Icon(Icons.save,),      
      onPressed: (_guardando) ? null : _submit
    );
  }

  void _submit() async{

  if( !formKey.currentState.validate() ) return;

    formKey.currentState.save();
  
    
    setState(() { _guardando = true;     });

    if(foto != null ){
      producto.fotoUrl = await productosBloc.subirFoto(foto);
    }

  if (producto.id == null) {
  productosBloc.agregarProducto(producto);
    
  }else{
    productosBloc.editarProducto(producto);
  }

  //setState(() { _guardando = false;});
  mostrarSnackbar('Registro guardado');

  Navigator.pop(context);
  }


 void mostrarSnackbar(String mensaje) {
    final snackbar = SnackBar(
      content: Text(mensaje),
      duration: Duration(milliseconds: 1500),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

    _mostrarFoto() {
 
    if (producto.fotoUrl != null) {
 
      return FadeInImage(
        image: NetworkImage(producto.fotoUrl),
        placeholder: AssetImage('assets/jar-loading.gif'),
        height: 300.0,
        fit: BoxFit.contain,
      );
 
    } else {
 
      if( foto != null ){
        return Image.file(
          foto,
          fit: BoxFit.cover,
          height: 300.0,
        );
      }
      return Image.asset('assets/no-image.png');
    }
  }
    
    _seleccionarFoto() async {
      _procesarImagen( ImageSource.gallery );
  }



    _procesarImagen( ImageSource origen) async {
    final _picker = ImagePicker();
 
    final pickedFile = await _picker.getImage(
      source: origen,
    );
    
    foto = File(pickedFile.path);
 
    if (foto != null) {
      producto.fotoUrl = null;
    }
 
    setState(() {});

  }
    _tomarFoto(){
      _procesarImagen(ImageSource.camera);
    }


}


