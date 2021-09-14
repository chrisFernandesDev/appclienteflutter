import 'dart:typed_data';

import 'package:appclienteflutter/controllers/user_controllers.dart';
import 'package:file_picker/file_picker.dart';
import '../models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String nome = "";
  String cpf = "";
  String end = "";
  String cep = "";
  String tel = "";
  String email = "";
  String senha = "";
  Uint8List? file;


  late final userController = Provider.of<UserController>(
    context,
    listen: false,
  );

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nova Conta"),
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
        child: Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
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
            ),
            Center(
              child: Container(
                alignment: Alignment.topCenter,
                child: Image(
                    fit: BoxFit.contain,
                    image: AssetImage('img/logo1.gif')),
              ),
            ),
            
            Container(
              margin:
                  EdgeInsets.only(top: 295, right: 30, left: 30),
              child: Column(
                children: [
                  if (isLoading) CircularProgressIndicator(),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(2.0)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(color: Colors.white, blurRadius: 2),
                        BoxShadow(color: Colors.white, blurRadius: 2),
                      ],
                    ),
                    padding: EdgeInsets.all(5),
                    child: TextField(
                      textCapitalization: TextCapitalization.words,
                      keyboardType: TextInputType.text,
                      onChanged: (texto) => nome = texto,
                      style: TextStyle(fontSize: 16.0, color: Colors.black),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(
                          FontAwesomeIcons.user,
                          color: Colors.grey,
                        ),
                        hintText: 'Name',
                        hintStyle: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ),
                  Container(
                    width: 250.0,
                    height: 1.0,
                    color: Colors.blue,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(2.0)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(color: Colors.white, blurRadius: 2),
                        BoxShadow(color: Colors.white, blurRadius: 2),
                      ],
                    ),
                    padding: EdgeInsets.all(5),
                    child: TextField(
                      textCapitalization: TextCapitalization.words,
                      keyboardType: TextInputType.text,
                      onChanged: (texto) => cpf = texto,
                      style: TextStyle(fontSize: 16.0, color: Colors.black),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(
                          FontAwesomeIcons.file,
                          color: Colors.grey,
                        ),
                        hintText: 'CPF',
                        hintStyle: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ),
                  Container(
                    width: 250.0,
                    height: 1.0,
                    color: Colors.blue,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(2.0)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(color: Colors.white, blurRadius: 2),
                        BoxShadow(color: Colors.white, blurRadius: 2),
                      ],
                    ),
                    padding: EdgeInsets.all(5),
                    child: TextField(
                      textCapitalization: TextCapitalization.words,
                      keyboardType: TextInputType.text,
                      onChanged: (texto) => end = texto,
                      style: TextStyle(fontSize: 16.0, color: Colors.black),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(
                          FontAwesomeIcons.locationArrow,
                          color: Colors.grey,
                        ),
                        hintText: 'Endereço',
                        hintStyle: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ),
                  Container(
                    width: 250.0,
                    height: 1.0,
                    color: Colors.blue,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(2.0)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(color: Colors.white, blurRadius: 2),
                        BoxShadow(color: Colors.white, blurRadius: 2),
                      ],
                    ),
                    padding: EdgeInsets.all(5),
                    child: TextField(
                      textCapitalization: TextCapitalization.words,
                      keyboardType: TextInputType.numberWithOptions(),
                      onChanged: (texto) => cep = texto,
                      style: TextStyle(fontSize: 16.0, color: Colors.black),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(
                          Icons.animation_rounded,
                          color: Colors.grey,
                        ),
                        hintText: 'CEP',
                        hintStyle: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ),
                  Container(
                    width: 250.0,
                    height: 1.0,
                    color: Colors.blue,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(2.0)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(color: Colors.white, blurRadius: 2),
                        BoxShadow(color: Colors.white, blurRadius: 2),
                      ],
                    ),
                    padding: EdgeInsets.all(5),
                    child: TextField(
                      textCapitalization: TextCapitalization.words,
                      keyboardType: TextInputType.phone,
                      onChanged: (texto) => tel = texto,
                      style: TextStyle(fontSize: 16.0, color: Colors.black),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(
                          FontAwesomeIcons.phone,
                          color: Colors.grey,
                        ),
                        hintText: 'Telefone',
                        hintStyle: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ),
                  Container(
                    width: 250.0,
                    height: 1.0,
                    color: Colors.blue,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(2.0)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(color: Colors.white, blurRadius: 2),
                        BoxShadow(color: Colors.white, blurRadius: 2),
                      ],
                    ),
                    padding: EdgeInsets.all(5),
                    child: TextField(
                      textCapitalization: TextCapitalization.words,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (texto) => email = texto,
                      style: TextStyle(fontSize: 16.0, color: Colors.black),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(
                          Icons.email,
                          color: Colors.grey,
                        ),
                        hintText: 'Email',
                        hintStyle: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ),
                  Container(
                    width: 250.0,
                    height: 1.0,
                    color: Colors.blue,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(2.0)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(color: Colors.white, blurRadius: 2),
                        BoxShadow(color: Colors.white, blurRadius: 2),
                      ],
                    ),
                    padding: EdgeInsets.all(5),
                    child: TextField(
                      textCapitalization: TextCapitalization.words,
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      onChanged: (texto) => senha = texto,
                      style: TextStyle(fontSize: 16.0, color: Colors.black),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(
                          FontAwesomeIcons.lock,
                          color: Colors.grey,
                        ),
                        hintText: 'Senha',
                        hintStyle: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.all(30),
                    child: 
                      ElevatedButton(
                      onPressed: () async {
                        final result = await FilePicker.platform
                            .pickFiles(type: FileType.image);
                        if (result != null) {
                          setState(() {
                            final bytes = result.files.first.bytes;
                            file = bytes;
                          });
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(file != null ? Icons.check : Icons.upload),
                            Text("Adicionar foto de perfil"),
                          ],
                        ),
                      ),
                ),
                    
                  ),

                  Container(
                    // margin: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      gradient: LinearGradient(
                        colors: <Color>[
                          Color.fromRGBO(232,231,238,1),
                          Color.fromRGBO(48,136,233,1),
                      
                          ],
                        ),
                    ),
                    child: MaterialButton(
                      highlightColor: Colors.transparent,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 42.0),
                        child: Text(
                          'Cadastrar',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 21.0,
                          ),
                        ),
                      ),
                      onPressed: () async {
                        try {
                          final user = UserModel(
                              nome: nome,
                              email: email,
                              cpf: cpf,
                              end: end,
                              cep: cep,
                              tel: tel,
                              imagem: file,

                          );
                          setState(() {
                            isLoading = true;
                          });
                          await userController.signup(email, senha, user);
                          Navigator.pop(context);
                        } on FirebaseAuthException catch (e) {
                          setState(() {
                            isLoading = true;
                          });
                          var msg = '';

                          if (e.code == 'weak-password') {
                            msg = 'Senha fraca';
                          } else if (e.code == 'email-already-in-use') {
                            msg = 'Email já cadastrado';
                          } else {
                            msg = 'Ocorreu um erro';
                          }
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(msg),
                            ),
                          );
                        }
                      },
                      // child: Text("Criar conta"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
