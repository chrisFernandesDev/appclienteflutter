import 'package:appclienteflutter/pages/splash_page.dart';
import 'controllers/user_controllers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Init.instance.initialize(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return MaterialApp(
              home: Splash(),
              debugShowCheckedModeBanner: false,
            );
          }
          else{
            return ChangeNotifierProvider(
              create: (context) => UserController(),
              child: MaterialApp(
                theme: ThemeData(
                  primarySwatch: Colors.pink,
                ),
                home: SplashPage(),
                debugShowCheckedModeBanner: false,
              ),
            );
          }
        });
  }
}
class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.purple,
      body: Center(
        child: Container(
          width: 450,
          height: 450,
            decoration: BoxDecoration(
                image: DecorationImage(
          image: AssetImage('img/SHOES.gif'),
          fit: BoxFit.cover,
        ))),
      ),
    );
  }
}

class Init {
  Init._();
  static final instance = Init._();

  Future initialize() async {
    await Future.delayed(Duration(seconds: 3));
  }
}
