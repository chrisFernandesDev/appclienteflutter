import 'package:appclienteflutter/controllers/user_controllers.dart';
import 'package:appclienteflutter/models/produto_model.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'carrinho_page.dart';

class PromocaoPage extends StatefulWidget {
  PromocaoPage({Key? key}) : super(key: key);

  @override
  _PromocaoPageState createState() => _PromocaoPageState();
}

class _PromocaoPageState extends State<PromocaoPage> {
  late final userController = Provider.of<UserController>(
    context,
    listen: false,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Promoções",
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
            tooltip: 'Seu carrinho de compras',
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CarrinhoPage()));
            },
          ),
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: <Color>[
            Color(0xfff8f9fa),
            Color(0xffced4da),
            Color(0xff89c2d9),
            Color(0xff014f86),
          ])),
        ),
        centerTitle: true,
      ),
      body:

          // Padding(
          //     padding: const EdgeInsets.all(20),
          //     child: Text(
          //       "Promoções Especiais",
          //       style: TextStyle(fontSize: 20),
          //     )),

          FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
              future: FirebaseFirestore.instance
                  .collection('produtos')
                  .where('promocao', isEqualTo: true)
                  .get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final produtos = snapshot.data!.docs.map(
                  (item) {
                    final dados = item.data();
                    return ProdutoModel.fromMap(dados);
                  },
                ).toList();

                return Column(
                    children: produtos.map(
                  (produto) {
                    return ListTile(
                      leading: produto.imagem != null
                          ? Image.memory(
                              produto.imagem!,
                              fit: BoxFit.contain,
                              width: 72,
                              height: 120,
                            )
                          : Container(
                              width: 125,
                              height: 125,
                              color: Colors.blue,
                            ),
                      title: Text(
                        produto.marca,
                        style: TextStyle(fontSize: 16),
                      ),
                      subtitle: Text(
                        produto.descricao,
                        style: TextStyle(fontSize: 12),
                      ),
                      trailing: Text(
                        "R\$ ${produto.preco}",
                        style: TextStyle(fontSize: 16),
                      ),
                    );
                  },
                ).toList());
              }),
    );
  }
}
