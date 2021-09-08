import 'package:appclienteflutter/controllers/user_controllers.dart';
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
      ),
      body: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: <Color>[Color(0xFFfbab66), Color(0xFFf7418c)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  tileMode: TileMode.clamp),
            ),
          ),
          
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 10),
              alignment: Alignment.topCenter,
              child: Image(
                  height:
                      MediaQuery.of(context).size.height > 800 ? 191.0 : 150,
                  fit: BoxFit.contain,
                  image: AssetImage('img/imgTest.png')),
            ),
          ),
          
          Container(
            margin: EdgeInsets.only(top: 220, right: 30, bottom: 30, left: 30),
            child: Column(
              children: [
                if (isLoading) CircularProgressIndicator(),
                Container(
                  decoration:  BoxDecoration(
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
                        color: Colors.black,
                      ),
                      hintText: 'Name',
                      hintStyle: TextStyle(fontSize: 16.0),
                    ),
                  ),
                ),
                Container(
                  width: 250.0,
                  height: 1.0,
                  color: Colors.red,
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
                        color: Colors.black,
                      ),
                      hintText: 'CPF',
                      hintStyle: TextStyle(fontSize: 16.0),
                    ),
                  ),
                ),
                Container(
                  width: 250.0,
                  height: 1.0,
                  color: Colors.red,
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
                        color: Colors.black,
                      ),
                      hintText: 'Endereço',
                      hintStyle: TextStyle(fontSize: 16.0),
                    ),
                  ),
                ),
                Container(
                  width: 250.0,
                  height: 1.0,
                  color: Colors.red,
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
                    onChanged: (texto) => cep = texto,
                    style: TextStyle(fontSize: 16.0, color: Colors.black),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      icon: Icon(
                        Icons.animation_rounded,
                        color: Colors.black,
                      ),
                      hintText: 'CEP',
                      hintStyle: TextStyle(fontSize: 16.0),
                    ),
                  ),
                ),
                Container(
                  width: 250.0,
                  height: 1.0,
                  color: Colors.red,
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
                    onChanged: (texto) => tel = texto,
                    style: TextStyle(fontSize: 16.0, color: Colors.black),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      icon: Icon(
                        FontAwesomeIcons.phone,
                        color: Colors.black,
                      ),
                      hintText: 'Telefone',
                      hintStyle: TextStyle(fontSize: 16.0),
                    ),
                  ),
                ),
                Container(
                  width: 250.0,
                  height: 1.0,
                  color: Colors.red,
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
                    onChanged: (texto) => email = texto,
                    style: TextStyle(fontSize: 16.0, color: Colors.black),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      icon: Icon(
                        Icons.email,
                        color: Colors.black,
                      ),
                      hintText: 'Email',
                      hintStyle: TextStyle(fontSize: 16.0),
                    ),
                  ),
                ),
                Container(
                  width: 250.0,
                  height: 1.0,
                  color: Colors.red,
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
                        color: Colors.black,
                      ),
                      hintText: 'Senha',
                      hintStyle: TextStyle(
                          fontSize: 16.0),
                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    gradient: LinearGradient(
                        colors: <Color>[
                          const Color.fromRGBO(240, 74, 233, 1),
                          const Color.fromRGBO(253, 133, 29, 1),
                          const Color.fromRGBO(252, 171, 69, 1),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        tileMode: TileMode.clamp
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
                          color: Colors.white,
                          fontSize: 25.0,
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
                            tel: tel);
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
    );
  }
}
