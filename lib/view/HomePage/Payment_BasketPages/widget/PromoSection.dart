import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:providerapp/viewModel/Bloc/order/order_cubit_bloc.dart';

import '../../../../Model/Components/CustomTextForm.dart';
import '../../../../Model/Components/CustumText.dart';
class PromoSection extends StatelessWidget {
  const PromoSection({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = OrderCubit.get(context);
    return   Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomTextField(
        controller: cubit.PromoCode,
        hintText: "Promo Code",
        icon: Image.asset("assets/Icons/Promo - icon (1).png"),
        suffixIcon: TextButton(
            onPressed: () {
              String currentPromo = cubit.PromoCode.text;
              if ((currentPromo == cubit.Promo) &
              cubit.promocodeDone) {
                cubit.totalPriceDiscount();
                Fluttertoast.showToast(
                    msg: "Congrats You got 20% Discount",
                    backgroundColor: Colors.green,
                    webPosition: "right");
              } else {
                Fluttertoast.showToast(msg: "Wrong Promo Code");
              }
            },
            child: const CustomText(
              text: "APPLY",
              fontWeight: FontWeight.bold,
              fontSize: 16,
            )),
      ),
    );
  }
}
