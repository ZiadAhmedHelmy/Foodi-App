import 'package:bloc/bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import 'package:providerapp/view/BasketPage.dart';
import 'package:providerapp/view/CategoriesPage.dart';
import 'package:providerapp/view/MainPage.dart';

import '../../../view/ProfilePage.dart';

part 'NavigationState.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(ProductCubitInitial());

  static NavigationCubit get(context) => BlocProvider.of(context);

  List pages = [MainPage(),const CategoriesPage() ,  BasketScreen(), const ProfilePage()];

  int selectedIndex = 0;

  void changeIndex(int index) {
    selectedIndex = index;
    emit(SelectedIndexChangingState());
  }
}
