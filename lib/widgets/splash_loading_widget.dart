import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashLoadingWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("MaxShoes"),
          Lottie.network("https://assets2.lottiefiles.com/packages/lf20_bivaxhip.json")
        ],
      ),
    );
  }
}