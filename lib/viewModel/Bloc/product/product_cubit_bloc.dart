import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:providerapp/Model/Models/ProductBanarModel.dart';
import 'package:providerapp/utils/Constant.dart';

import '../../../Model/Models/FoodModel.dart';

part 'product_cubit_state.dart';

class ProductCubit extends Cubit<ProductCubitState> {
  ProductCubit() : super(ProductCubitInitial()) ;

  static ProductCubit get(context) => BlocProvider.of(context);




  List<BannerModel> carouselItems = [
  ];

  List<FoodModel> foodList = [];

  int currentIndex = 0;

  double TotalPrice = 0 ;


  FoodModel guessedFood = FoodModel();
  int randomIndex = 0;

  Future<void>getAllFoodFire()async {
    emit(LoadingAllFoodState());
    await FirebaseFirestore.instance.collection(Collection.menu).snapshots().listen((value) {
      foodList.clear();
      for (var doc in value.docs ) {
         foodList.add(FoodModel.fromJason(doc.data()));
      }
      emit(SuccessAllFoodState());
    });
  }




  Future<void>getBannerFoodFire()async {
    emit(LoadingBannerFoodState());
    FirebaseFirestore.instance.collection(Collection.foodBanner).snapshots().listen((value) {
      carouselItems.clear();
      for (var doc in value.docs) {
          carouselItems.add(BannerModel.fromJason(doc.data()));

      }
      emit(SuccessBannerFoodState());
    });
  }
  void changeIndex(int index) {
    currentIndex = index;
    foodList[index];
    emit(ChangeIndexState());
  }




  // Future<void> guessFoodForUser()async {
  //   emit(LoadingBannerFoodState());
  //   FirebaseFirestore.instance.collection(Collection.menu).snapshots().listen((value) {
  //     carouselItems.clear();
  //     for (var doc in value.docs) {
  //       carouselItems.add(BannerModel.fromJason(doc.data()));
  //
  //     }
  //     emit(SuccessBannerFoodState());
  //   });
  // }

  FoodModel getRandomElement() {
    Random random = Random();
     randomIndex = random.nextInt(foodList.length);
    return foodList[randomIndex];
  }

  void guessedFoodUser(){
    guessedFood = getRandomElement();
    emit(GetRandomFoodUserState());
  }








}
