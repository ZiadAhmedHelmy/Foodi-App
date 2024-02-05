part of 'category_cubit_bloc.dart';

@immutable
abstract class CategoryCubitState {}

class CategoryCubitInitial extends CategoryCubitState {}



// get all Categories States
class LoadingAllCategoriesState extends CategoryCubitState {}
class SuccessAllCategoriesState extends CategoryCubitState {}
class ErrorAllCategoriesState extends CategoryCubitState {}



// Changing Category List Index
class ChangeIndexState extends CategoryCubitState{}


// get Specific Product Category

class LoadingProductsCategoriesState extends CategoryCubitState{}
class SuccessProductsCategoriesState extends CategoryCubitState{}


// ShimmerState

class ShimmerOffState extends CategoryCubitState{}
