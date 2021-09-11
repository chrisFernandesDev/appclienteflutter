import 'package:appclienteflutter/controllers/produto_controllers.dart';
import 'package:appclienteflutter/controllers/user_controllers.dart';
import 'package:provider/provider.dart';

import '../models/produto_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'carrinho_page.dart';

class MasculinoPage extends StatefulWidget {

  @override
  _MasculinoPageState createState() => _MasculinoPageState();
}
// heloo everybody
class _MasculinoPageState extends State<MasculinoPage> {
      late final userController = Provider.of<UserController>(
    context,
    listen: false,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       title: Text('masculino'),
      actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.white,),
            tooltip: 'Seu carrinho de compras',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => CarrinhoPage()));
            },
          ),
        ],

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
        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('produtos')
            .where('categoria', isEqualTo: 'masculino')
            // .orderBy('')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final produtos = snapshot.data!.docs.map((map) {
            final data = map.data();
            return ProdutoModel.fromMap(data, map.id);
          }).toList();

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount: produtos.length,
            itemBuilder: (context, index) {
              final produto = produtos[index];
              return ListTile(
                // title: Text(produto.categoria),
                subtitle: Column(
                  children: [Icon(Icons.paid_rounded), Text(produto.marca)],
                ),
                leading: produto.imagem != null
                ? Image.memory(
                  produto.imagem!,
                  fit: BoxFit.cover,
                  width: 72,
                )
                : Container(
                  child: Icon(Icons.card_giftcard),
                  width: 72,
                  height: double.maxFinite,
                  color: Colors.blue,
                ),
                                trailing: IconButton(
                  icon: Icon(Icons.shopping_cart),
                  
                  onPressed: () async {
                    final produtos = ProdutoModel(
                      ownerKey: produto.ownerKey, 
                      categoria: produto.categoria,
                      cor: produto.cor,
                      descricao: produto.descricao,
                      marca: produto.marca,
                      nome: produto.nome,
                      preco: produto.preco,
                      tamanho: produto.tamanho,   
                      imagem: produto.imagem,                   
                    ).toMap();
                    produtoController.addProduto(produtos); print(produtos);
                  }
                ),

              );
            },
          );
        },
      ),
    );
  }
}