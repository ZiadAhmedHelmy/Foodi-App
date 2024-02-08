import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:providerapp/Model/Components/CustumText.dart';
import 'package:providerapp/Model/widgets/BannerFoodCard.dart';
import 'package:providerapp/Model/widgets/FoodCardWidget.dart';
import 'package:providerapp/utils/AppColors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:providerapp/viewModel/Bloc/BottomNavigationCubit/NavigationBloc.dart';
import 'package:providerapp/viewModel/Bloc/product/product_cubit_bloc.dart';

import '../../Model/Components/SeachBar.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = NavigationCubit.get(context);
    return BlocConsumer<NavigationCubit, NavigationState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          body: cubit.pages[cubit.selectedIndex],
          bottomNavigationBar: BottomNavigationBar(

            currentIndex: NavigationCubit
                .get(context)
                .selectedIndex,
            onTap: (index) {
              cubit.changeIndex(index);
            },
            backgroundColor: AppColor.white,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'Home',
              ),

              BottomNavigationBarItem(
                icon: Icon(Icons.category_rounded),
                label: 'Categories',
              ),

              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_basket),
                label: 'Basket',
              ),

              BottomNavigationBarItem(
                icon: Icon(Icons.ac_unit),
                label: 'Profile',
              ),
            ],
            selectedItemColor: AppColor.orange,
            unselectedItemColor: AppColor.grey,

          ),
        );
      },
    );
  }
}
