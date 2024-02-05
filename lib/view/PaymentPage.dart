import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:providerapp/Model/Components/CustomButton.dart';
import 'package:providerapp/Model/widgets/PaymentMethodCard.dart';
import 'package:providerapp/utils/AppColors.dart';
import 'package:providerapp/view/HomePage.dart';
import 'package:providerapp/view/MainPage.dart';
import 'package:providerapp/viewModel/Bloc/BottomNavigationCubit/NavigationBloc.dart';
import 'package:providerapp/viewModel/Bloc/ButtonCounterCubit/button_counter_cubit.dart';
import 'package:providerapp/viewModel/Bloc/UserProfile/profile_cubit.dart';
import 'package:providerapp/viewModel/Bloc/order/order_cubit_bloc.dart';
import 'package:quickalert/quickalert.dart';

import '../Model/Components/CustumText.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = ProfileCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.orange,
        elevation: 0,
        title: CustomText(
          text: "Payment Method",
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColor.white,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomText(
                    text: "Select Method",
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return PaymentMethodCard(
                    text: cubit.paymentList[index],
                    index: index,
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ),
                itemCount: cubit.paymentList.length),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomButton(
                text: "Confirm",
                color: AppColor.orange,
                textColor: AppColor.white,
                onTap: () {
                  if (cubit.selectPaymentIndex != -1) {
                    // QuickAlert.show(
                    //     context: context, type: QuickAlertType.success,title: "Congratulations!",
                    //     text: "Your order has been confirmed successfully",
                    //     textAlignment: TextAlign.center,
                    //
                    // );
                    showDialog(
                      context: context,
                      builder: (context){
                        return  Stack(
                          children: [
                             AlertDialog(
                                title: const CustomText(text: "Congratulations!" ,  fontWeight: FontWeight.bold , fontSize: 24,textAlign: TextAlign.center),
                                alignment: Alignment.center,
                                content:  Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [

                                    CustomText(text: "Your order has been confirmed successfully" ,textAlign: TextAlign.center,color: AppColor.grey,fontSize: 18,fontWeight: FontWeight.w600, ),
                                    const SizedBox(height: 15,),
                                    CustomButton(text: "Thanks", color:AppColor.orange ,textColor: AppColor.white,  onTap: (){

                                    }),
                                  ],
                                )
                            ),
                            Align( alignment:Alignment.topCenter ,child:SvgPicture.asset("assets/Icons/Frame 1932.svg")),

                          ],
                        );
                      },
                    );
                  } else {
                    Fluttertoast.showToast(msg: "Select a Payment Method");
                  }
                }),
          ),
        ],
      ),
    );
  }
}
