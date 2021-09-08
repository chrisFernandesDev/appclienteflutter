

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class PayPage extends StatefulWidget {
  PayPage({Key? key}) : super(key: key);

  @override
  _PayPageState createState() => _PayPageState();
}

class _PayPageState extends State<PayPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         title:Text("Formas de Pagamentos")
       ),

       body:Column(
         mainAxisAlignment: MainAxisAlignment.center,
        children: [
          
          ListTile(
            title: Text(
              "Formas de Pagamentos Disponíveis",
              textAlign: TextAlign.center,
              style: GoogleFonts.martel(
              textStyle: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w300,
                  letterSpacing: -1.5)
              )
               
               
            ),
          ), 

          Container(
                    
                    child: Image.asset(
                      "assets/images/formas-pagto1.jpg",
                      height: 420,
                      width: 420,
                      alignment: Alignment.center,
                      
                    ),
                    
                  ),
           
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              IconButton( 
                            icon: FaIcon(
                              FontAwesomeIcons.envelopeSquare,
                              size: 50,
                              color: Colors.black,
                              
                            ),
                            onPressed: () async =>
                                await launch("https://mail.google.com/mail/u/0/#inbox")
                        ),
                            SizedBox(
                  width: 20,
                ),
                IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.whatsapp,
                      size: 50,
                      color: Colors.black,
                    ),
                    onPressed: () async =>
                        await launch("https://wa.me/${5511960232774}")
                ),
            ],
            
          ),

                 
       ],
          
          
              
                
        
         
        
      ) ,
    );
  }
}