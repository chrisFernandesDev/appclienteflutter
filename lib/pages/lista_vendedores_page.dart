import 'package:appclienteflutter/models/vendedor_model.dart';
import 'package:appclienteflutter/pages/loja_vendedor_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListaVendedores extends StatefulWidget {

  @override
  _ListaVendedoresState createState() => _ListaVendedoresState();
}

class _ListaVendedoresState extends State<ListaVendedores> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vendedores'),
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
      body: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
              future: FirebaseFirestore.instance.collection('admin')
              .get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final vendedores = snapshot.data!.docs.map(
                  (item) {
                    final dados = item.data();
                    return VendedorModel.fromMap(dados, item.id);
                  },
                ).toList();

                return Column(
                    children: vendedores.map(
                  (vendedor) {
                    return ListTile(
                      leading: vendedor.imagem != null
                          ? Image.memory(
                              vendedor.imagem!,
                              fit: BoxFit.contain,
                              width: 72,
                              height: 120,
                            )
                          : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                                child: Icon(Icons.person, color: Colors.white,),
                                backgroundColor: Colors.blue,
                            ),
                          ),
                      title: Text(
                        vendedor.nome,
                        style: TextStyle(fontSize: 16),
                      ),
                      onTap: () async{
                        
                      //  final dados = VendedorModel(
                      //    nome: ,
                      //    key: 
                      //    ).toMap(); 
                      //  await
                       Navigator.push(context,
                       MaterialPageRoute(builder: (context) => LojaVendedor()),
                       );
                    setState(() {

                    });
                      },
                    );
                  },
                ).toList());
              }),


    );
  }
}
