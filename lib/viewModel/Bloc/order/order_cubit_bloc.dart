
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:providerapp/Model/Models/BasketFoodModel.dart';

import 'package:providerapp/viewModel/data/SharedKeys.dart';
import 'package:providerapp/viewModel/data/SharedPrefrences.dart';

import '../../../Model/Models/OrderModel.dart';
import '../../../Model/Models/ShippingInfoModel.dart';
import '../../../utils/Constant.dart';


part 'order_cubit_state.dart';

 class OrderCubit extends Cubit<OrderCubitState> {
  OrderCubit() : super(OrderCubitInitial()) ;

  static OrderCubit get(context) => BlocProvider.of(context);

  int productCount = 0 ;
  int currentCountProduct = 0;
  static double totalPrice = 0 ;

  TextEditingController PromoCode = TextEditingController();

  String Promo = "ziad";

  bool promocodeDone = true;

   List<BasketFoodModel>readyOrdersList = [];



   /// Shipping Infooo
  List<ShippingInfoModel> shipInfo = [];



  // Shipping Section Info

  int selectedCardIndex = -1;
  ShippingInfoModel? selectedInfo;





  // Payment Method

  int selectPaymentIndex = -1;

  List<String>paymentList = [
    "Cash on Delivery",
  ];


  // Shipping Info
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();




  // OrderHistoryList

  List<OrderModel> orderHistory = [];


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

  Future<void>setUserShippingInfo()async {
    emit(LoadingSetShippingInfo());
    await FirebaseFirestore.instance.collection(Collection.users).doc(LocalData.getData(key: SharedKey.uid)).collection("ShippingInfo").add({
      "address" :address.text,
      "phoneNumber":phoneNumber.text,
      "title":title.text,
    }).then((value){
      selectedCardIndex = -1;
      emit(SuccessSetShippingInfo());
    } );

  }


  Future<void>getUserShippingInfo()async {
    emit(LoadingGetShippingInfo());
    await FirebaseFirestore.instance.collection(Collection.users).doc(LocalData.getData(key: SharedKey.uid)).collection("ShippingInfo").snapshots().listen((value) {
      shipInfo.clear();
      for (var doc in value.docs) {
        shipInfo.add(ShippingInfoModel.fromJason(doc.data()));
      }
      emit(SuccessGetShippingInfo());
    });




  }


  void selectInfoFromListInfo({required int currentIndex}){
    selectedCardIndex = currentIndex;
    selectedInfo = shipInfo[currentIndex];
    emit(SuccessSelectedInfo());


  }

  void selectPaymentMethod({required int currentIndex}){
    selectPaymentIndex = currentIndex;
    paymentList[selectPaymentIndex];
    emit(SelectedPaymentMethod());

  }
  void claerUserShippingInfo(){
    address.clear();
    phoneNumber.clear();
    title.clear();
  }



  Future<void> setOrder(String date) async {

    emit(OrderLoadingState());

   await FirebaseFirestore.instance.collection(Collection.orders).add({
      "Price": totalPrice,
      "foodDiscription": readyOrdersList.map((basket) => basket.toJson()).toList(),
      "address": selectedInfo?.address,
       "OrderDate":date,
      "uid": LocalData.getData(key: SharedKey.uid),
    }).then((value) {
      print(LocalData.getData(key: SharedKey.uid));
      emit(OrderSuccessState());
    }).catchError((error){
       emit(OrderErrorState());
   });
  }



  Future<void> getOrders() async {
    emit(GetLoadingOrderHistory());
   await FirebaseFirestore.instance.collection(Collection.orders).where("uid" , isEqualTo: LocalData.getData(key: SharedKey.uid)).snapshots().listen((value) {
     orderHistory.clear();
     for (var doc in value.docs) {
       orderHistory.add(OrderModel.fromJason(doc.data()));
     }
     emit(GetSuccessOrderHistory());
    });

  }








 }
