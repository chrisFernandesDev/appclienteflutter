import 'package:appclienteflutter/pages/carrinho_page.dart';

import '../controllers/produto_controllers.dart';
import '../controllers/user_controllers.dart';
import '../models/pedido_model.dart';
import '../models/produto_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InfantilPage extends StatefulWidget {
  @override
  _InfantilPageState createState() => _InfantilPageState();
}

// heloo everybody
class _InfantilPageState extends State<InfantilPage> {
  late final userController = Provider.of<UserController>(
    context,
    listen: false,
  );

  // final ProdutoModel produto;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Infantil'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            tooltip: 'Seu carrinho de compras',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => CarrinhoPage()));
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('produtos')
            .where('categoria', isEqualTo: 'infantil')
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
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemCount: produtos.length,
            itemBuilder: (context, index) {
              final produto = produtos[index];
              return ListTile(
                title: Text(produto.categoria),
                subtitle: Row(
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
                    ).toMap();
                    produtoController.addProduto(produtos);
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
