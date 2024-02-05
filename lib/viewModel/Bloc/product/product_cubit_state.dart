part of 'product_cubit_bloc.dart';

@immutable
abstract class ProductCubitState {}

class ProductCubitInitial extends ProductCubitState {}



// States of All Food
class LoadingAllFoodState extends ProductCubitState {}
class SuccessAllFoodState extends ProductCubitState {}

// States of Banner Food
class LoadingBannerFoodState extends ProductCubitState {}
class SuccessBannerFoodState extends ProductCubitState {}


// Selecting Current Product
class ChangeIndexState extends ProductCubitState {}



// guessed FoodUser

class GetRandomFoodUserState extends ProductCubitState{}
