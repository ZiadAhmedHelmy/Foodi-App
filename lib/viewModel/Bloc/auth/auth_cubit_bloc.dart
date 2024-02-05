
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:providerapp/utils/AppColors.dart';
import 'package:providerapp/utils/Constant.dart';
import 'package:providerapp/viewModel/data/SharedKeys.dart';
import 'package:providerapp/viewModel/data/SharedPrefrences.dart';

import 'auth_cubit_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);

  // Login Controllers
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  TextEditingController loginEmail = TextEditingController();
  TextEditingController loginPassword = TextEditingController();

  // Register Controllers
  GlobalKey<FormState> registerKey = GlobalKey<FormState>();
  TextEditingController userName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();


  //value.user?.updateDisplayName();
  Future<void> fireAuthLogin() async {
    emit(LoadingLoginState());
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: loginEmail.text,
      password: loginPassword.text,
    ).then((value) {
      print(value.user?.email);

      storeDataFirebase(value);
      Fluttertoast.showToast(
          msg: "Login Successfully", backgroundColor: AppColor.orange);
      emit(SuccessfulLoginState());
    }).catchError((error) {
      Fluttertoast.showToast(msg: error);
      emit(ErrorLoginState());
    });
  }


  void storeDataFirebase(UserCredential value) {
    print("Using StoreDataFirebase");
    LocalData.setData(key: SharedKey.uid, value: value.user?.uid);
    LocalData.setData(key: SharedKey.email, value: value.user?.email);
    LocalData.setData(key: SharedKey.userName, value: value.user?.displayName);
  }


  Future<void> signUpWithFire() async {
    emit(LoadingRegisterState());
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text, password: password.text).then((value) async {
      print(value.user?.email);
      print(value.user?.uid);
      value.user?.updateDisplayName(userName.text);
      await addUserToFireStore(value);
      Fluttertoast.showToast(
          msg: "SignUp Successfully", backgroundColor: AppColor.orange);
      emit(SuccessfulLoginState());
    }).catchError((error) {
      emit(ErrorRegisterState());
      Fluttertoast.showToast(msg: error.toString());
      print(error);
    });
  }


  Future<void> signOut() async {
    emit(LoadingSignOutState());
    await FirebaseAuth.instance.signOut().then((value) async {
      emit(SuccessfulSignOutState());
      Fluttertoast.showToast(
          msg: "SignOut Successfully", backgroundColor: AppColor.orange);
    }).catchError((error) {
      emit(ErrorSignOutState());
      Fluttertoast.showToast(msg: error.toString());
      print(error);
    });
  }


  Future<void> addUserToFireStore(UserCredential userCredential) async {
    await FirebaseFirestore.instance.collection(Collection.users).doc(
        userCredential.user?.uid).set({
      "Email": email.text,
      "UserName": userName.text,
      "profileImage" : "jppp",
      "uid": userCredential.user?.uid
    });
    print("gooood");
  }
    void clearLoginControllerAndData() {
      loginEmail.clear();
      loginPassword.clear();
    }
    void clearRegisterControllers() {
      userName.clear();
      password.clear();
      email.clear();
    }






}
