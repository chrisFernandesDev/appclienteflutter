
import 'package:appclienteflutter/models/produto_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';




class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage>{

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
    var userController;
    return Scaffold(
      

//DRAWER ------------------------------------------------------------------------------

drawer: Drawer(
  child: Column(
    children:[
      UserAccountsDrawerHeader(
        currentAccountPicture: Image.network('https://images.unsplash.com/photo-1527980965255-d3b416303d12?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=80'),
        accountName: Text('Usuario', style: TextStyle(fontSize: 20),), 
        accountEmail: Text('usuario@gmail.com', style: TextStyle(fontSize: 18),),
      ),
      ListTile(
              title: const Text('Masculino', style: TextStyle(fontSize: 25),),
              onTap: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context) => NomeMasculino()),
              },
            ),
            ListTile(
              title: const Text('Feminino', style: TextStyle(fontSize: 25),),
              onTap: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context) => NomeFeminino()),
              },
            ),
            ListTile(
              title: const Text('Infantil', style: TextStyle(fontSize: 25),),
              onTap: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context) => NomeInfantil()),
              },
            ),
            ListTile(
              title: const Text('Promoções', style: TextStyle(fontSize: 25),),
              onTap: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context) => NomeInfantil()),
              },
            ),

            ListTile(
              title: const Text('_______________________________'),
              onTap: () {
                
                Navigator.pop(context);
              },
            ),

            ListTile(
              title: const Text('Informaçõess', style: TextStyle(fontSize: 25),),
              onTap: () {
                
                Navigator.pop(context);
              },
            ),
],
  ),
),


//BARRA SUPERIOR ------------------------------------------------------------------

      appBar: AppBar(
        title: Text ("MAX Shoes", style: TextStyle(
          fontSize: 18,
          // fontWeight: FontWeight.w100,
        ),
        ),
        
flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  Color(0xff0097E3),
                  Color(0xffCA2547),
          ])
        ),
      ),
      centerTitle: true,
    ),
  


//CAROUSEL ----------------------------------------------------------------------

      body:SingleChildScrollView(
        child: Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
              ),
              items: imagesList.map(
                (item) => Center(
                  child: Image.network(
                    item,
                    fit: BoxFit.cover,
                    height: 600,
                    width: 900,
                  ),
                ),
              ).toList(),
            ),

//PRODUTOS DO FIREBASE-------------------------------------------------------------            
      Padding(
        padding: const EdgeInsets.all(30),
        child: Text("Nossos Produtos",)
      ),   
      
FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
        future: FirebaseFirestore.instance
            .collection('produtos')
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
            (produto){
              return Container(
                width: double.maxFinite,
                child: ListTile(
                  leading: produto.imagem != null
                      ? Image.memory(
                          produto.imagem!,
                          fit: BoxFit.contain,
                          width: 125,
                          height: 125,
                        )
                      : Container(
                          width: 125,
                          height: 125,
                          color: Colors.blue,
                        ),
                  title: Text(
                    produto.nome,
                    style: TextStyle(fontSize: 21),
                  ),
                  subtitle: Text(
                    produto.descricao,
                    style: TextStyle(fontSize: 16),
                  ),
                  trailing: Text(
                    "R\$ ${produto.preco}",
                    style: TextStyle(fontSize: 21),
                  ),
                ),
              );
            },
          ).toList()
        );
      }
    )



          ],
        )
      ),
    );
  }
}






