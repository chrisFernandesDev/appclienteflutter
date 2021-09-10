import 'package:appclienteflutter/models/pedido_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../controllers/produto_controllers.dart';
import '../controllers/user_controllers.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class CarrinhoPage extends StatefulWidget {
  @override
  _CarrinhoPageState createState() => _CarrinhoPageState();
}

class _CarrinhoPageState extends State<CarrinhoPage> {
  late final userController = Provider.of<UserController>(
    context,
    listen: false,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carrinho de compras'),
      ),
      body: Container(
        child: AnimatedBuilder(
            animation: produtoController,
            builder: (context, Widget? child) => Container(
                    
                      child: TextButton(
                        child: Text('Comprar'),
                        onPressed: () {
                          final novaCompra = PedidoModel(
                                  clienteKey: userController.user!.uid,
                                  pedido: produtoController.produto,
                                  clienteNome: userController.model.nome,
                                  // key: userController.model.key!
                                  )
                              .toMap();                              

                          FirebaseFirestore.instance
                              .collection('vendas')
                              .add(novaCompra);

                          setState(() {
                            produtoController.produto.clear();
                          });

                          // SnackBar(
                          //   Text("Compra Realizada")
                          // );
                        },
                      ),
                    )),
      ),

    

    );
  }
}