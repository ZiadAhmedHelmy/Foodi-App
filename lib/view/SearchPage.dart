import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:providerapp/Model/Components/PopUpWidget.dart';
import 'package:providerapp/Model/widgets/FoodCardWidget.dart';
import 'package:providerapp/view/ProductPage.dart';
import 'package:providerapp/viewModel/Bloc/product/product_cubit_bloc.dart';

import '../Model/Components/CustomTextForm.dart';
import '../Model/Components/CustumText.dart';
import '../Model/Models/FoodModel.dart';
import '../utils/AppColors.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool isLoading = true;
  TextEditingController searchedItem = TextEditingController();
  List<FoodModel> foundList = [];

  @override
  void initState() {
    super.initState();
    foundList = ProductCubit.get(context).allFoodList;
    Future.delayed(
      const Duration(seconds: 1),
      () {
        setState(() {
          isLoading = false;
        });
      },
    );
  }

  void filterItems(String enteredKeyword) {
    List<FoodModel> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = ProductCubit.get(context).allFoodList;
    } else {
      results = ProductCubit.get(context)
          .allFoodList
          .where((item) => item.foodName!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }
    setState(() {
      foundList = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    var cubitProduct = ProductCubit.get(context);
    return BlocProvider.value(
      value: cubitProduct..getAllFoodFire(),
      child: Scaffold(
        appBar: AppBar(
          leading:PopUpWidget(icon: FluentIcons.arrow_autofit_up_24_regular, color:AppColor.white  , ),
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
                child: Material(
                    child: CustomTextField(
                        icon: const Icon(FluentIcons.search_12_filled),
                        controller: searchedItem,
                        hintText: "Search...",
                        keyboardType: TextInputType.name,
                        onChanged: (value) => filterItems(value))),
              ),
            ),
            Expanded(
              child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: foundList.length,
                itemBuilder: (context, index) {
                  return FoodCard(
                      item: foundList[index],
                      onTap: () {
                        cubitProduct.currentIndex = index;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductPage(
                                item: foundList[index],
                              ),
                            ));
                      });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
