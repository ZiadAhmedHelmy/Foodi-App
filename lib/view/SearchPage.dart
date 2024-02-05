import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:providerapp/Model/widgets/FoodCardWidget.dart';
import 'package:providerapp/viewModel/Bloc/product/product_cubit_bloc.dart';

import '../Model/Components/CustomTextForm.dart';
import '../Model/Components/CustumText.dart';
import '../utils/AppColors.dart';
class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = ProductCubit.get(context);
    TextEditingController f = TextEditingController();
    return BlocProvider.value(
       value: cubit..getAllFoodFire(),
  child: Scaffold(
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
          
          Expanded(
            child: GridView.builder(  physics: const BouncingScrollPhysics(), gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2) ,itemCount: cubit.allFoodList.length, itemBuilder: (context, index) {
               return FoodCard(item:cubit.allFoodList[index] , onTap: (){});
            },),
          )

        ],
      ),
    ),
);
  }
}
