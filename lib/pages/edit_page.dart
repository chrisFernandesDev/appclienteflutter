import 'package:appclienteflutter/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class EditPage extends StatefulWidget {
  final UserModel usuarios;

  EditPage({required this.usuarios});

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  late final nomeCont = TextEditingController()..text = widget.usuarios.nome;
  late final cpfCont = TextEditingController()..text = widget.usuarios.cpf;
  late final enderecoCont = TextEditingController()..text = widget.usuarios.end;
  late final cepCont = TextEditingController()..text = widget.usuarios.cep;
  late final telCont = TextEditingController()..text = widget.usuarios.tel;
  late final emailCont = TextEditingController()..text = widget.usuarios.email;
  late final keyCont = TextEditingController()..text = widget.usuarios.key!;
  // late Uint8List? file = widget.usuarios.imagem;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Editar usuarios"),
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection('usuarios')
                    .doc(widget.usuarios.key)
                    .delete();
                Navigator.pop(context);
              },
              icon: Icon(Icons.delete, color: Colors.white,)),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: nomeCont,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.perm_identity),
                  labelText: "Nome",
                ),
              ),
              TextField(
                controller: enderecoCont,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.location_on),
                  labelText: "Endereço",
                ),
              ),
              TextField(
                controller: telCont,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.phone),
                  labelText: "Telefone",
                ),
              ),
              TextField(
                controller: cepCont,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.home),
                  labelText: "Cep",
                ),
              ),
              TextField(
                controller: cpfCont,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.folder_shared),
                  labelText: "Cpf",
                ),
              ),
              TextField(
                controller: emailCont,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.mail_outline),
                  labelText: "E-mail",
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              // ElevatedButton(
              //   onPressed: () async {
              //     final result =
              //         await FilePicker.platform.pickFiles(type: FileType.image);

              //     if (result != null) {
              //       setState(() {
              //         final bytes = result.files.first.bytes;
              //         file = bytes;
              //       });
              //     }
              //   },
              //   child: Row(
              //     children: [
              //       Icon(file != null ? Icons.check : Icons.upload),
              //       Text("Adicionar imagem"),
              //     ],
              //   ),
              // ),
              const SizedBox(height: 8),
              OutlinedButton(
                  onPressed: () async {
                    final atualizado = UserModel(
                            key: widget.usuarios.key,
                            nome: nomeCont.text,
                            end: enderecoCont.text,
                            cep: cepCont.text,
                            tel: telCont.text,
                            cpf: cpfCont.text,
                            email: emailCont.text
                            // imagem: file,
                            )
                        .toMap();
                    print(atualizado);
                    await FirebaseFirestore.instance
                        .collection('usuarios')
                        .doc(widget.usuarios.key)
                        .update(atualizado);

                    Navigator.pop(context);
                  },
                  child: Text("Atualizar Usuario")),
                  
            ],
          ),
        ),
      ),
    );
  }
}
