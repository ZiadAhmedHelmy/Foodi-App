import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:providerapp/Model/Components/CustumText.dart';

import 'package:providerapp/view/HomePage/Payment_BasketPages/BasketPage.dart';
import 'package:providerapp/view/HomePage/Category_SectionPages/CategoriesPage.dart';
import 'package:providerapp/view/HomePage/MainPage/MainPage.dart';

import '../../../utils/AppColors.dart';
import '../../../view/HomePage/ProfilePage/ProfilePage.dart';
import '../../data/SharedKeys.dart';

part 'NavigationState.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(ProductCubitInitial());

  static NavigationCubit get(context) => BlocProvider.of(context);


  List pages = [MainPage(),const CategoriesPage() ,  ChartScreen(), const ProfilePage()];

  int selectedIndex = 0;

  void changeIndex(int index) {
    selectedIndex = index;
    emit(SelectedIndexChangingState());
  }


  TabBar get tabBar => TabBar(
    indicatorColor: AppColor.orange,
    indicatorWeight: 4,
    labelColor: AppColor.orange,
    unselectedLabelColor: AppColor.grey,
    padding:const EdgeInsets.all(5),
    indicatorPadding: const EdgeInsets.symmetric(horizontal: 5),
    tabs: const [
      Tab(text: "Login", height:60 ),

      Tab(text: 'Sign Up'),
    ],
  );



}
