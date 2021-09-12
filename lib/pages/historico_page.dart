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
        title: Text("Usuários"),
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

                // var cor = usuario.clienteKey == userController.model.key
                //     ? Colors.red
                //     : Colors.white;

                return ListTile(
                leading: Icon(Icons.person),
                title: Text(usuario.clienteNome),
                // subtitle:Text(usuario.pedido.join({})),
                subtitle: Text('${usuario.pedido[0]['preco']}'),

                  // tileColor: cor,
                );
              });
        },
      ),
    );
  }
}
