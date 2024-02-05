import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
     return Container(
         width: 390,
         height: 272,
         decoration: const BoxDecoration(
             gradient: LinearGradient(
               begin: Alignment.topRight, end: Alignment.bottomLeft,
               colors: [Color(0xffff5b28), Color(0xffff8159)], )),
         child: Column(
       mainAxisAlignment: MainAxisAlignment.center,
       children: [
         SvgPicture.asset("assets/Images/Foodi.svg"),
         const SizedBox(height: 16,),
         const Text("Foodi ",style: TextStyle(color: Colors.white , fontSize: 48 , fontWeight: FontWeight.bold), ),
       ],
     )
     );

  }
}
