import 'package:flutter/material.dart';
class PopUpWidget extends StatelessWidget {

   IconData icon;
   Color color;
   PopUpWidget({super.key, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap:(){
          Navigator.pop(context);
        },
        child: Icon(icon ,color:color ,));
  }
}
