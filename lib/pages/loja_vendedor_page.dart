import 'package:flutter/material.dart';

class LojaVendedor extends StatefulWidget {

  @override
  _LojaVendedorState createState() => _LojaVendedorState();
}

class _LojaVendedorState extends State<LojaVendedor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Loja do Vendedor'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  
                  colors: <Color>[
                  Color(0xfff8f9fa),
                  Color(0xffced4da),
                  Color(0xff89c2d9),
                  Color(0xff014f86),
              ]
              )
              ),
        ),
      ),
    );
  }
}