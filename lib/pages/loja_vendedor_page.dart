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
      ),
    );
  }
}