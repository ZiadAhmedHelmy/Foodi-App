import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:providerapp/utils/AppColors.dart';
import 'package:providerapp/view/HomePage/HomePage.dart';
import 'package:providerapp/view/HomePage/Login_RegisterPages/LoginPage.dart';
import 'package:providerapp/view/OnBorading.dart';
import 'package:providerapp/viewModel/data/SharedKeys.dart';
import 'package:providerapp/viewModel/data/SharedPrefrences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  bool _showOnboarding = true;

  @override
  void initState() {
    super.initState();
    _checkFirstLaunch();
  }

  _checkFirstLaunch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstLaunch = prefs.getBool('firstLaunch') ?? true;

    setState(() {
      _showOnboarding = isFirstLaunch;
    });

    if (isFirstLaunch) {
      prefs.setBool('firstLaunch', false);
    }
  }



  @override
  Widget build(BuildContext context) {
    return  AnimatedSplashScreen(
      backgroundColor: AppColor.orange,
          splash:Column(
             mainAxisSize: MainAxisSize.max,

            children: [
              SvgPicture.asset("assets/Images/Foodi.svg" , width: 30 ,fit: BoxFit.fill,),

              const Text("Foodi",style: TextStyle(color: Colors.white , fontSize: 28 , fontWeight: FontWeight.bold),),

            ],
          ),
          nextScreen: _showOnboarding ? Onbording() :  ( LocalData.getData(key: SharedKey.uid) != null) ?      HomePage() :  const Login_Register_Page(),
          animationDuration: const Duration(seconds: 2),
        splashTransition: SplashTransition.fadeTransition,
      );
  }
}