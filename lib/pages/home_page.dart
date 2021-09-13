import 'package:appclienteflutter/controllers/user_controllers.dart';
import 'package:appclienteflutter/models/produto_model.dart';

import 'package:appclienteflutter/pages/edit_page.dart';
import 'package:appclienteflutter/pages/feminino_page.dart';
import 'package:appclienteflutter/pages/historico_page.dart';
import 'package:appclienteflutter/pages/infantil_page.dart';
import 'package:appclienteflutter/pages/lista_vendedores_page.dart';
import 'package:appclienteflutter/pages/masculino_page.dart';
import 'package:appclienteflutter/pages/pay_page.dart';
import 'package:appclienteflutter/pages/promocoes_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

import 'carrinho_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
//IMAGENS CAROUSEL--------------------------------------------------------------------

  final List<String> imagesList = [
    'https://images.unsplash.com/photo-1544754565-5655962dc338?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80',
    'https://images.unsplash.com/photo-1465877783223-4eba513e27c6?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80',
    'https://images.unsplash.com/photo-1606318175645-8e425336f08f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=750&q=80',
    'https://images.unsplash.com/photo-1517784648376-0bdfdc01a1aa?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=726&q=80',
    'https://images.unsplash.com/photo-1516478177764-9fe5bd7e9717?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=750&q=80',
  ];

//--------------------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    late final userController = Provider.of<UserController>(
      context,
      listen: false,
    );

    return Scaffold(
//DRAWER ------------------------------------------------------------------------------

      drawer: Drawer(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: <Color>[
                      Color(0xfff8f9fa),
                      Color(0xffced4da),
                      Color(0xff89c2d9),
                      Color(0xff014f86)
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    tileMode: TileMode.clamp),
              ),
              child: UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                    foregroundImage: MemoryImage(userController.model.imagem!)),
                accountName: Text(userController.model.nome),
                accountEmail: Text(userController.user!.email!),
              ),
            ),
            ListTile(
              leading: Icon(Icons.male),
              title: const Text(
                'Masculino',
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MasculinoPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.female),
              title: const Text(
                'Feminino',
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FemininoPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.child_care),
              title: const Text(
                'Infantil',
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InfantilPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.shop),
              title: const Text(
                'Promoções',
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PromocaoPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.sell),
              title: const Text(
                'Vendedores',
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListaVendedores()),
                );
              },
            ),
            Container(
              width: 250.0,
              height: 1.0,
              color: Colors.grey,
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: const Text(
                'Informações',
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PayPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: const Text(
                'Histórico de Compras',
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HistoricoPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.edit),
              title: const Text(
                'Atualizar Cadastro',
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          EditPage(usuarios: userController.model)),
                );
              },
            ),
            Container(
              width: 250.0,
              height: 1.0,
              color: Colors.grey,
            ),
            ListTile(
              leading: IconButton(
                onPressed: () async {
                  await userController.logout();
                },
                icon: Icon(Icons.exit_to_app),
              ),
              title: const Text(
                'Sair',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),

//BARRA SUPERIOR ------------------------------------------------------------------

      appBar: AppBar(
        title: Text(
          "MaxShoes",
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

//CAROUSEL ----------------------------------------------------------------------

      body: SingleChildScrollView(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
              ),
              items: imagesList
                  .map(
                    (item) => Center(
                      child: Image.network(
                        item,
                        fit: BoxFit.cover,
                        height: 600,
                        width: 900,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),

//PRODUTOS DO FIREBASE-------------------------------------------------------------
          Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Promoções da Semana",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              )),

          FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
              future: FirebaseFirestore.instance.collection('produtos').get(),
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
        ],
      )),
    );
  }
}
