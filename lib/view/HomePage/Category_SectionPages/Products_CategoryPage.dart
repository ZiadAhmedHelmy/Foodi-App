import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:providerapp/Model/Components/CustumText.dart';
import 'package:providerapp/Model/Components/PopUpWidget.dart';
import 'package:providerapp/Model/Shimmers/CategoryShimmer.dart';
import 'package:providerapp/view/HomePage/Category_SectionPages/widget/ProductCategoryWidget.dart';
import 'package:providerapp/utils/AppColors.dart';
import 'package:providerapp/view/HomePage/Category_SectionPages/widget/ProductListCategory.dart';
import 'package:providerapp/view/ProductPage.dart';
import 'package:providerapp/viewModel/Bloc/Categories/category_cubit_bloc.dart';
import 'package:providerapp/viewModel/Bloc/product/product_cubit_bloc.dart';

import '../../../Model/Components/CustomTextForm.dart';
import '../../../Model/Models/FoodModel.dart';

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
                  leading: PopUpWidget(icon: FluentIcons.arrow_autofit_up_24_regular , color: AppColor.white,),
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
                              child: LoadingAnimationWidget.bouncingBall(color: AppColor.orange, size: 50),)
                        ],
                      )
                    : Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomTextField(
                                icon: const Icon(FluentIcons.search_12_filled),
                                controller: searchedItem,
                                hintText: "Search...",
                                keyboardType: TextInputType.name,
                                onChanged: (value) => filterItems(value)),
                          ),
                          Expanded(
                            child: ProductListCategory(foundList: foundList,),
                          ),
                        ],
                      ));
          },
        ),
      ),
    );
  }
}
