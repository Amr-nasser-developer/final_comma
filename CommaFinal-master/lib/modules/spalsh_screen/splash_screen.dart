import 'package:comma/modules/on_Boarding/onBoarding.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      navigateRoute: OnBoarding(),
      duration: 3000,
      imageSize: 200,
      imageSrc: "assets/images/splash1.png",
      backgroundColor: HexColor('#265AE8'),
    );
  }
}
