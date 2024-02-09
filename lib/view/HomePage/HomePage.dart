import 'package:fluentui_system_icons/fluentui_system_icons.dart';
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
                icon: Icon(FluentIcons.home_12_regular),
                label: 'Home',
              ),

              BottomNavigationBarItem(
                icon: Icon(FluentIcons.filter_12_filled),
                label: 'Categories',
              ),

              BottomNavigationBarItem(
                icon: Icon(FluentIcons.cart_16_regular),
                label: 'Basket',
              ),

              BottomNavigationBarItem(
                icon: Icon(FluentIcons.person_arrow_left_24_regular),
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
