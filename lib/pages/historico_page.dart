import 'package:appclienteflutter/controllers/user_controllers.dart';
import 'package:appclienteflutter/models/pedido_model.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoricoPage extends StatefulWidget {
  @override
  _HistoricoPageState createState() => _HistoricoPageState();
}

class _HistoricoPageState extends State<HistoricoPage> {
  late final userController = Provider.of<UserController>(
    context,
    listen: false,
  );

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Histórico de compras"),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('vendas')
            .where('clienteKey', isEqualTo: userController.user!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final usuarios = snapshot.data!.docs.map(
            (documento) {
              final dados = documento.data();
              return PedidoModel.fromMap(dados);
            },
          ).toList();

          

          return ListView.builder(
              itemCount: usuarios.length,
              itemBuilder: (context, index) {
              final usuario = usuarios[index];

                return ListTile(
                  isThreeLine: true,
                leading: Icon(Icons.person),
                trailing: Text(usuario.clienteNome),
                subtitle: Row(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      child: Image.memory(usuario.pedido[0]['imagem'].bytes)),
                    Container(child: Text('${usuario.pedido[0]['marca']}')),
                    Container(child: Text('${usuario.pedido[0]['categoria']}')),
                    Container(child: Text('${usuario.pedido[0]['preco']}')),
                    // Text('${usuario.pedido[0]['preco']}'),

                  ],
                ),

                  // tileColor: cor,
                );
              });
        },
      ),
    );
  }
}
