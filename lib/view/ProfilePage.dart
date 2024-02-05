import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:providerapp/Model/Components/CustomButton.dart';
import 'package:providerapp/Model/Components/CustumText.dart';
import 'package:providerapp/view/LoginPage.dart';
import 'package:providerapp/viewModel/Bloc/auth/auth_cubit_bloc.dart';
import 'package:providerapp/viewModel/Bloc/auth/auth_cubit_state.dart';
import 'package:providerapp/viewModel/Bloc/order/order_cubit_bloc.dart';
import 'package:providerapp/viewModel/data/SharedKeys.dart';
import 'package:providerapp/viewModel/data/SharedPrefrences.dart';

import '../utils/AppColors.dart';
import '../viewModel/Bloc/UserProfile/profile_cubit.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    var User = ProfileCubit.get(context);
    return BlocProvider.value(
      value: ProfileCubit.get(context)
        ..getUserInfoFire(),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {

          return  Scaffold(
            appBar: AppBar(
              backgroundColor: AppColor.orange,
              elevation: 0,
            ),
            body: Column(
              children: [

                Stack(children: [
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      color: AppColor.orange,
                      borderRadius:const BorderRadius.only(bottomRight: Radius.circular(50) , bottomLeft: Radius.circular(50))
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () {
                        User.takePhotoFromUser();
                      },
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 3),
                            ),
                            child: CircleAvatar(
                                backgroundColor: AppColor.grey,
                                radius: 60,
                                backgroundImage: CachedNetworkImageProvider(
                                    "${User.User?.profileImage}",
                                ),
                            ),
                          ),

                          Column(
                            children: [
                              CustomText(
                                text: LocalData.getData(key: SharedKey.userName),
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: AppColor.white,
                              ),
                              const SizedBox(height: 5,),
                              CustomText(text: LocalData.getData(key: SharedKey.email),color: Colors.grey.shade100),

                            ],
                          ),

                        ],
                      ),
                    ),
                  ),
                ]),


                CustomText(text: "Orders History",color: AppColor.orange , fontWeight: FontWeight.w700 ,fontStyle: FontStyle.italic),

                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    // TODO: implement listener
                  },
                  builder: (context, state) {
                    return CustomButton(
                        text: "LogOut",
                        color: AppColor.orange,
                        textColor: AppColor.white,
                        onTap: () {
                          AuthCubit.get(context).signOut();
                          BasketCubit.get(context).clearData();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Login_Register_Page(),
                              ));
                          LocalData.clearData();
                        });
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
