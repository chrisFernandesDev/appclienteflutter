import 'package:appclienteflutter/controllers/user_controllers.dart';
import 'package:appclienteflutter/models/pedido_model.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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
                .collection('vendas')
                .where('clienteKey', isEqualTo: userController.user!.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              final pedido = snapshot.data!.docs.map(
                (documento) {
                  final dados = documento.data();
                  return PedidoModel.fromMap(dados);
                },
              ).toList();

              return ListView.builder(
                      shrinkWrap: true,
                      // physics: NeverScrollableScrollPhysics(),
                      itemCount: pedido.length,
                      itemBuilder: (context, index) {
                        final pedidoFinal = pedido[index];
                        return ListTile(
                            isThreeLine: true,
                            leading: Icon(Icons.checklist_sharp),
                            // trailing: Text(usuario.clienteNome),
                            subtitle: Column(
                              children: [
                                Container(
                                    width: 100,
                                    height: 100,
                                    child: Image.memory(
                                        pedidoFinal.pedido[0]['imagem'].bytes)),
                                Container(
                                    child: Text(
                                        '${pedidoFinal.pedido[0]['marca']} ')),
                                Container(
                                    child: Text(
                                        '${pedidoFinal.pedido[0]['categoria']} ')),
                                Container(
                                  child: RatingBar.builder(
                                    itemSize: 25,
                                    initialRating: 0,
                                    minRating: 0,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemPadding:
                                        EdgeInsets.symmetric(horizontal: 4.0),
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) {
                                      // print("");
                                    },
                                  ),
                                ),
                                // Container(
                                //     child: Text(
                                //         '${pedidoFinal.pedido[0]['preco']} ')),
                                // Text('${usuario.pedido[0]['preco']}'),
                              ],
                            ),
                            trailing:
                                Text('R\$ ${pedidoFinal.pedido[0]['preco']} '));
                      });
                },
              
            ));
  }
}
