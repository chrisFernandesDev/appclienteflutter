import 'package:appclienteflutter/controllers/produto_controllers.dart';
import 'package:appclienteflutter/models/produto_model.dart';
import 'package:appclienteflutter/models/vendedor_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'carrinho_page.dart';

class LojaVendedor extends StatefulWidget {

  @override
  _LojaVendedorState createState() => _LojaVendedorState();
}

class _LojaVendedorState extends State<LojaVendedor> {
    late final vendedor = Provider.of<VendedorModel>(
    context,
    listen: false,
  );

  TextEditingController textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Loja do Vendedor'),
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
      ),
  body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('produtos')
            // .where('ownerKey', isEqualTo:  vendedor.key)
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
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1, childAspectRatio: 2,),
            
            itemCount: produtos.length,            
            itemBuilder: (context, index) {
              final produto = produtos[index];
              return SafeArea(
                child: Container(
                padding: EdgeInsets.all(10),
                child: ListTile(
                  title: Padding(
                    padding: EdgeInsets.all(4.0),
                    child: produto.imagem != null
                        ? Image.memory(
                            produto.imagem!,
                            fit: BoxFit.cover,
                            width: 72,
                            height: 100,
                          )
                        : Container(
                            child: Icon(Icons.card_giftcard),
                            width: 72,
                            height: 100,
                            color: Colors.blue,
                          ),
                  ),
                  tileColor: Colors.black12,
                  subtitle: Container(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '${produto.marca} ' + '  R\$ ${produto.preco}',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                          

                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          produto.descricao,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                  trailing: OutlinedButton(
                    onPressed: () {},
                    child: IconButton(
                      icon: Icon(
                        Icons.add,
                        size: 30,
                        color: Colors.white,
                      ),
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
                        produtoController.addProduto(produtos);
                        print(produtos);
                      },
                    ),
                    style: OutlinedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: EdgeInsets.only(
                            top: 10, bottom: 15, left: 10, right: 15),
                        backgroundColor: Colors.black54),
                  ),
                ),
              ));
            },
          );
        },
      ),
    );
  }
}
  //   );
  // }}

