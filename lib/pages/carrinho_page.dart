import 'dart:html';

import 'package:appclienteflutter/models/pedido_model.dart';
import 'package:appclienteflutter/models/produto_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: produtoController.produto.isEmpty
            ? 1
            : produtoController.produto.length,
        itemBuilder: (context, index) {
          var produtoFinal;
          if (produtoController.produto.isEmpty) {
            Text("Carrinho Vazio :(");
          } else {
            produtoFinal =
                ProdutoModel.fromMap(produtoController.produto[index]);
          }

          return AnimatedBuilder(
              animation: produtoController,
              builder: (context, Widget? child) {
                return produtoController.produto.isEmpty
                    ? Center(
                        child: Text("Cheguei ate aquiiiiiiiiiiiiiiiii"),
                      )
                    : Column(
                        children: <Widget>[
                          produtoFinal != null
                              ? Row(
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 100,
                                      // child: Image.memory(
                                      //   produtoFinal!,
                                      //   width: 72,
                                      //   fit: BoxFit.contain,
                                      // ),
                                    ),
                                  ],
                                )
                              : Container(
                                  child: Icon(Icons.no_photography),
                                  width: 72,
                                  height: double.maxFinite,
                                  color: Colors.pink,
                                ),

                          Text('${produtoFinal.nome}'),

                          InkWell(
                            onTap: () {
                              produtoController.removeProduto(
                                  produtoController.produto[index]);
                            },
                            child: FaIcon(
                              FontAwesomeIcons.solidTrashAlt,
                              size: 15,
                            ),
                          ),

                          // Text("${produtoFinal.imagem}"),
                          Text("${produtoFinal.preco}"),
                          Text("${produtoFinal.descricao}"),
                          // Text("${produtoFinal.precoTotal}"),

                          InkWell(
                            child: TextButton(
                              child: Text('Comprar'),
                              onPressed: () {
                                final novaCompra = PedidoModel(
                                  clienteKey: userController.user!.uid,
                                  pedido: produtoController.produto,
                                  clienteNome: userController.model.nome,
                                  // key: userController.model.key!
                                ).toMap();

                                FirebaseFirestore.instance
                                    .collection('vendas')
                                    .add(novaCompra);

                                setState(() {
                                  produtoController.produto.clear();
                                });

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Compra Realizada"),
                                  ),
                                );
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ],
                      );
              }
              );
        },
      ),

      // floatingActionButton:
      // Text("TAMOAE"),
    );
  }
}
