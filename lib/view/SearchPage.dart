import 'package:flutter/material.dart';

import '../Model/Components/CustomTextForm.dart';
import '../Model/Components/CustumText.dart';
import '../utils/AppColors.dart';
class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController f = TextEditingController();
    return Scaffold(
       appBar: AppBar(
         backgroundColor: AppColor.orange,
         elevation: 0,
         title: CustomText(
           text: "Menu",
           fontSize: 18,
           fontWeight: FontWeight.w600,
           color: AppColor.white,
         ),
         centerTitle: true,
       ),
      body: Column(
        children: [
          Hero(
            tag: "SearchBar",
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(child: CustomTextField(icon:const Icon(Icons.search) ,controller: f, hintText: "Search..." ,keyboardType: TextInputType.name,onTap: (){}, )),
            ),
            ),

        ],
      ),
    );
  }
}
