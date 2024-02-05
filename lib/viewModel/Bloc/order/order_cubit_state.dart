part of 'order_cubit_bloc.dart';

@immutable
abstract class OrderCubitState {}

class OrderCubitInitial extends  OrderCubitState {}



// add & remove Product Quantity
class AddFoodCountState extends  OrderCubitState {}
class RemoveFoodCountState extends  OrderCubitState {}


// Selecting Current Product
class ChangeIndexState extends  OrderCubitState {}


// Total Price
class TotalPriceChangeState extends  OrderCubitState {}


// Remove Product from Basket
class RemoveProductState extends OrderCubitState{}


// discount on totalPrice
class DiscountTotalPriceState extends OrderCubitState{}
