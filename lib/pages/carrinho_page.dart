import 'package:appclienteflutter/models/pedido_model.dart';
import 'package:appclienteflutter/models/produto_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

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
        body: SingleChildScrollView(
            child: Container(
          child: Column(children: [
            AnimatedBuilder(
                animation: produtoController,
                builder: (BuildContext context, Widget? child) {
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: produtoController.produto.isEmpty
                          ? 1
                          : produtoController.produto.length,
                      itemBuilder: (context, index) {
                        var produtoFinal;
                        if (produtoController.produto.isEmpty) {
                          return Lottie.network(
                              "https://assets8.lottiefiles.com/packages/lf20_x7Qnzj.json");
                        } else {
                          produtoFinal = ProdutoModel.fromMap(
                              produtoController.produto[index]);
                        }

                        // return AnimatedBuilder(
                        //     animation: produtoController,
                        //     builder: (context, Widget? child) {
                        return Column(
                          children: <Widget>[
                            produtoFinal != null
                                ? Row(
                                    children: [
                                      Container(
                                        width: 100,
                                        height: 100,
                                      ),
                                    ],
                                  )
                                : Container(
                                    child: Icon(Icons.no_photography),
                                    width: 72,
                                    height: double.maxFinite,
                                    color: Colors.pink,
                                  ),

                            Image.memory(produtoFinal.imagem),
                            Text('${produtoFinal.nome}'),
                            Text("${produtoFinal.preco}"),
                            Text("${produtoFinal.descricao}"),
                            // Text("${produtoFinal.precoTotal}"),

                            InkWell(
                              onTap: () {
                                produtoController.removeProduto(
                                    produtoController.produto[index]);
                                // print(produtoController.produto[index]);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FaIcon(
                                  FontAwesomeIcons.solidTrashAlt,
                                  size: 25,
                                ),
                              ),
                            ),
                  
                          ],
                        );
                      }
                      );
                }),  
                InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                        child: Text('Comprar', style: TextStyle(fontSize: 25)),
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
                  )
          ]),
          )
          )
          );
  }
}