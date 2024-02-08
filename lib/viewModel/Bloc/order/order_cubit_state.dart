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








// ShippingState  Set
class LoadingSetShippingInfo extends OrderCubitState{}
class SuccessSetShippingInfo extends OrderCubitState{}


// ShippingState Get
class LoadingGetShippingInfo extends OrderCubitState{}
class SuccessGetShippingInfo extends OrderCubitState{}


// SelectedInfoState

class SuccessSelectedInfo extends OrderCubitState{}



// Selected Payment Method

class SelectedPaymentMethod extends OrderCubitState{}




// OrderStates
  class OrderLoadingState extends OrderCubitState{}
  class OrderSuccessState extends OrderCubitState{}
  class OrderErrorState extends OrderCubitState{}



// OrderGetHistory

class GetLoadingOrderHistory extends OrderCubitState{}
class GetSuccessOrderHistory extends OrderCubitState{}
