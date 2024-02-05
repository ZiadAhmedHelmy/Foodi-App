import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:providerapp/Model/Components/CustumText.dart';
import 'package:providerapp/Model/Shimmers/CategoryShimmer.dart';
import 'package:providerapp/Model/widgets/ProductCategoryWidget.dart';
import 'package:providerapp/utils/AppColors.dart';
import 'package:providerapp/viewModel/Bloc/Categories/category_cubit_bloc.dart';

import '../Model/Models/FoodModel.dart';

class ProductsCategoryPage extends StatefulWidget {
  const ProductsCategoryPage({super.key});

  @override
  State<ProductsCategoryPage> createState() => _ProductsCategoryPageState();
}

class _ProductsCategoryPageState extends State<ProductsCategoryPage> {
  bool isLoading = true;
  TextEditingController searchedItem = TextEditingController();
  List<FoodModel> foundList = [];

  @override
  void initState() {
    super.initState();
    foundList = CategoryCubit.get(context).productsCategoryList;
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
      results = CategoryCubit.get(context).productsCategoryList;
    } else {
      results = CategoryCubit.get(context).productsCategoryList
          .where((item) =>
          item.foodName!.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }
    setState(() {
      foundList = results;
    });

  }

  @override
  Widget build(BuildContext context) {
    var categoryCubit = CategoryCubit.get(context);
    return BlocProvider.value(
      value: categoryCubit
        ..getAllProductOfSpecificCategory(
            categoryIndex: categoryCubit.currentIndex),
      child: SafeArea(
        child: BlocConsumer<CategoryCubit, CategoryCubitState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return Scaffold(
                resizeToAvoidBottomInset: false,
                appBar: AppBar(
                  backgroundColor: AppColor.orange,
                  elevation: 0,
                  title: CustomText(
                    text:
                        "${categoryCubit.categoryList[categoryCubit.currentIndex].categoryName}",
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColor.white,
                  ),
                  centerTitle: true,
                ),
                body: isLoading
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                              child: CircularProgressIndicator(
                            color: AppColor.orange,
                          )),
                        ],
                      )
                    : Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SearchBar(
                              onChanged:(value) => filterItems(value),
                                leading:  Icon(Icons.search , color: AppColor.grey),
                                hintText: "search",
                                controller:searchedItem,
                                hintStyle: MaterialStateProperty.all(
                                    TextStyle(color: AppColor.grey))),
                          ),
                          Expanded(
                            child: ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              itemCount:foundList.length,
                              itemBuilder: (context, index) {
                                return ProductCategory(
                                    item: foundList[index]);
                              },
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                height: 15,
                              ),
                            ),
                          ),
                        ],
                      ));
          },
        ),
      ),
    );
  }
}
