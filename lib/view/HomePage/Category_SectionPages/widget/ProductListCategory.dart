import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:providerapp/viewModel/Bloc/Categories/category_cubit_bloc.dart';

import '../../../../Model/Models/FoodModel.dart';
import 'ProductCategoryWidget.dart';

class ProductListCategory extends StatelessWidget {
   List<FoodModel> foundList = [];
   ProductListCategory({super.key , required this.foundList});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoryCubit, CategoryCubitState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemCount: foundList.length,
          itemBuilder: (context, index) {
            return ProductCategory(
              item: foundList[index]
              , index: index,
            );
          },
          separatorBuilder: (context, index) =>
          const SizedBox(
            height: 15,
          ),
        );
      },
    )
    ;
  }
}
