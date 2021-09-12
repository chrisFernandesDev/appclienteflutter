import 'package:appclienteflutter/controllers/user_controllers.dart';
import 'package:appclienteflutter/pages/cadastrar_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = "";
  String senha = "";
  String error = "";

  late final userController = Provider.of<UserController>(
    context,
    listen: false,
  );

  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),

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
      body: Stack(
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
              margin: EdgeInsets.only(top: 0),
              alignment: Alignment.topCenter,
              child: Image(
                  height: 350,
                      // MediaQuery.of(context).size.height > 800 ? 191.0 : 150,
                  fit: BoxFit.contain,
                  image: AssetImage('img/logo1.gif')),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 320, right: 30, bottom: 30, left: 30),
            child: Column(
              children: [
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
                    style: TextStyle(fontSize: 16.0, color: Color(0xff343a40)),
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
                  // margin: EdgeInsets.only(top: 10),
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
                    onChanged: (texto) => senha = texto,
                    style: TextStyle(fontSize: 16.0, color: Color(0xff343a40)),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      icon: Icon(
                        FontAwesomeIcons.lock,
                        color: Colors.grey,
                      ),
                      hintText: 'Senha',
                      hintStyle: TextStyle(fontSize: 16.0, ),
                    ),
                  ),
                ),

                CheckboxListTile(
                    checkColor: Colors.white,
                    value: isChecked,
                    title: Text("Deseja se manter logado?"),
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
              ),
                  
                Container(
                  margin: EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    color: Color(0xff468faf),
                     
                  ),
                  child: MaterialButton(
                    highlightColor: Colors.transparent,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 42.0),
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: Color(0xff343a40),
                          fontSize: 21.0,
                        ),
                      ),
                    ),
                    onPressed: () async {
                      try {
                        await userController.login(email, senha);
                      } on FirebaseAuthException catch (e) {
                        var msg = "";

                        if (e.code == "wrong-password") {
                          msg = "A senha está incorreta";
                        } else if (e.code == "invalid-email") {
                          msg = "Email inválido";
                        } else {
                          msg = "Ocorreu um erro";
                        }

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(msg),
                          ),
                        );
                      }
                    },                   
                  ),
                ),

                MaterialButton(
                  padding: EdgeInsets.only(top: 20),
                  child: Text("Cadastrar", 
                    style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                    ),
                  ),
                  
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUpPage(),
                      ),
                    );
                  },
                ),

                
              ],
            ),
          ),
        ],
      ),
    );
  }
}
