
import 'package:bloc/bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta/meta.dart';
import 'package:providerapp/Model/Models/BasketFoodModel.dart';


part 'order_cubit_state.dart';

 class BasketCubit extends Cubit<OrderCubitState> {
  BasketCubit() : super(OrderCubitInitial()) ;

  static BasketCubit get(context) => BlocProvider.of(context);

  int productCount = 0 ;
  int currentCountProduct = 0;
  static double totalPrice = 0 ;

  TextEditingController PromoCode = TextEditingController();

  String Promo = "ziad";

  bool promocodeDone = true;

   List<BasketFoodModel>readyOrdersList = [];


   void removeProduct(int index){
       readyOrdersList.removeAt(index);
       emit(RemoveProductState());
   }


  void totalPriceIncrese(double foodPrice , int foodCount){
    totalPrice+=(foodPrice*foodCount);
    emit(TotalPriceChangeState());
  }


  void totalPriceDecrease(double foodPrice , int foodCount){
    totalPrice-=(foodPrice*foodCount);
    emit(TotalPriceChangeState());
  }

  void totalPriceDiscount(){
     if(promocodeDone){
       totalPrice=totalPrice*0.8;
       promocodeDone = false;
     }else{
       Fluttertoast.showToast(msg: "Used PromoCode");
     }

     emit(DiscountTotalPriceState());
  }

  void clearData(){
     readyOrdersList.clear();
     PromoCode.clear();
  }









}
