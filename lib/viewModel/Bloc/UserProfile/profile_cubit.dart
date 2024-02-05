
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:providerapp/Model/Models/UserModel.dart';
import 'package:providerapp/utils/Constant.dart';
import 'package:providerapp/viewModel/data/SharedKeys.dart';
import 'package:providerapp/viewModel/data/SharedPrefrences.dart';

import '../../../Model/Models/ShippingInfoModel.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  static ProfileCubit get(context) => BlocProvider.of(context);



  XFile? image;

  String? imageUrlUser;

  UserModel? User;

  // Shipping Info
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();

  List<ShippingInfoModel> shipInfo = [];



  // Shipping Section Info

  int selectedCardIndex = -1;
  ShippingInfoModel? selectedInfo;





  // Payment Method

  int selectPaymentIndex = -1;

  List<String>paymentList = [
    "Cash on Delivery",
  ];




  void takePhotoFromUser()async{
    emit(UploadImageLoadingState());

    image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if(image == null){
      emit(UploadImageErrorState());
      Fluttertoast.showToast(msg: "No Image Picked" ,backgroundColor: Colors.black);
      return;
    }
    uploadImage(image: image!, onSuccess: (value){
      print(value);
      imageUrlUser = value;
      updateImageUser ();
      emit(UploadImageSuccessState());
    });
  }




  Future<void> uploadImage ({required XFile image ,  required Function(String) onSuccess})async {
    print(image.name);
    await FirebaseStorage.instance.ref().child("ProfileImage/${image.name}").putFile(File(image.path)).then((photo) {
      photo.ref.getDownloadURL().then((value) => onSuccess(value));
    });



  }

  Future<void> updateImageUser ()async {
    await FirebaseFirestore.instance.collection(Collection.users).doc(LocalData.getData(key: SharedKey.uid)).update({'profileImage': imageUrlUser});
    print(LocalData.getData(key: SharedKey.uid));
    print(imageUrlUser);
    emit(UpadteImageSuccess());

  }


  Future<void>getUserInfoFire()async {
    emit(LoadingUserInfoState());
    await FirebaseFirestore.instance.collection(Collection.users).snapshots().listen((value) {
      for (var doc in value.docs) {
        String docUid = doc.get('uid');
        if (LocalData.getData(key: SharedKey.uid) == docUid) {
          print(doc.id);
          print(LocalData.getData(key: SharedKey.uid));
          User = UserModel(
            email: doc.get('Email'),
            userName: doc.get("UserName"),
            profileImage: doc.get("profileImage"),
          );
          print(User?.email);
      }
      }
      emit(SuccessUserInfoState());
    });
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



  void claerUserShippingInfo(){
    address.clear();
    phoneNumber.clear();
    title.clear();
  }



  void selectPaymentMethod({required int currentIndex}){
     selectPaymentIndex = currentIndex;
     paymentList[selectPaymentIndex];
    emit(SelectedPaymentMethod());

  }



}
