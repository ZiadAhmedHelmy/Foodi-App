import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:providerapp/Model/Models/FoodModel.dart';
import 'package:shimmer/shimmer.dart';
import '../../../Model/Models/CategoryModel.dart';
import '../../../utils/Constant.dart';
part 'category_cubit_state.dart';


class CategoryCubit extends Cubit<CategoryCubitState> {
  CategoryCubit() : super(CategoryCubitInitial());

  static CategoryCubit get(context) => BlocProvider.of(context);

  List<CategoryModel> categoryList = [];
  List<DocumentSnapshot> docList = [];

  List<FoodModel> productsCategoryList = [];

  int  currentIndex =0;

  bool shimmerOff = true;


  Future<void>getAllCategoriesFire()async {
    emit(LoadingAllCategoriesState());
    await FirebaseFirestore.instance.collection(Collection.categories).snapshots().listen((value) {
      categoryList.clear();
      for (var doc in value.docs) {
        categoryList.add(CategoryModel.fromJason(doc.data()));
      }
      docList = value.docs;
      emit(SuccessAllCategoriesState());
    });
  }

  Future<void>getAllProductOfSpecificCategory({required int categoryIndex})async {
    emit(LoadingProductsCategoriesState());

    // Nested Collection of Doc of Collection
    await FirebaseFirestore.instance.collection(Collection.categories).doc(docList[categoryIndex].id).collection("Products").snapshots().listen((value)  {
      productsCategoryList.clear();
      for (var doc in value.docs) {
        productsCategoryList.add(FoodModel.fromJason(doc.data()));
      }
      emit(SuccessProductsCategoriesState());
    });


  }

  void changeIndex(int index) {
    currentIndex = index;
    productsCategoryList[currentIndex];
    emit(ChangeIndexState());
  }

  void clearData() {
    productsCategoryList.clear();

  }


  void turnOFFShimmer(){
     shimmerOff = false;
     emit(ShimmerOffState());
  }






}
