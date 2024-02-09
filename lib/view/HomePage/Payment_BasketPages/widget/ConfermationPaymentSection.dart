import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:providerapp/viewModel/Bloc/order/order_cubit_bloc.dart';

import '../../../../Model/Components/CustomButton.dart';
import '../../../../Model/Components/CustumText.dart';
import '../../../../utils/AppColors.dart';
class ConformationPaymentSection extends StatelessWidget {
  const ConformationPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = OrderCubit.get(context);
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomButton(
          text: "Confirm",
          color: AppColor.orange,
          textColor: AppColor.white,
          onTap: () {
            if (cubit.selectPaymentIndex != -1) {
              String OrderDate =
              DateFormat("MMM d,h:mm a").format(DateTime.now()).toString();
              cubit.setOrder(OrderDate);
              cubit.clearForPaymentDone();
              Navigator.pop(context);
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (context) {
                  return Stack(
                    children: [
                      AlertDialog(
                          title: const CustomText(
                              text: "Congratulations!",
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              textAlign: TextAlign.center),
                          alignment: Alignment.center,
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomText(
                                text:
                                "Your order has been confirmed successfully",
                                textAlign: TextAlign.center,
                                color: AppColor.grey,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              CustomButton(
                                  text: "Thanks",
                                  color: AppColor.orange,
                                  textColor: AppColor.white,
                                  onTap: () {}),
                            ],
                          )),
                      Align(
                          alignment: Alignment.topCenter,
                          child: SvgPicture.asset(
                              "assets/Icons/Frame 1932.svg")),
                    ],
                  );
                },
              );
            } else {
              Fluttertoast.showToast(msg: "Select a Payment Method");
            }
          }),
    );
  }
}
