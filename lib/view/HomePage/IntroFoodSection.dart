import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Model/widgets/FoodCardWidget.dart';
import '../../viewModel/Bloc/product/product_cubit_bloc.dart';
import '../ProductPage.dart';
class IntroFoodSection extends StatelessWidget {
  const IntroFoodSection({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = ProductCubit.get(context);
    return BlocConsumer<ProductCubit, ProductCubitState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
          itemCount: cubit.introFoodList.length,
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return FoodCard(
                item: cubit.introFoodList[index],
                onTap: () {
                  cubit.changeIndex(index);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductPage(
                          item: cubit
                              .introFoodList[cubit.currentIndex],
                        ),
                      ));
                });
          },
          separatorBuilder: (context, index) =>
          const SizedBox(
            width: 16,
          ),
        );
      },
    );
  }
}
