import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:providerapp/view/HomePage/Payment_BasketPages/widget/ConfermationPaymentSection.dart';
import 'package:providerapp/view/HomePage/Payment_BasketPages/widget/PaymentMethodCard.dart';
import 'package:providerapp/utils/AppColors.dart';

import 'package:providerapp/viewModel/Bloc/order/order_cubit_bloc.dart';

import '../../../Model/Components/CustumText.dart';
import '../../../Model/Components/PopUpWidget.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = OrderCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        leading: PopUpWidget(
          icon: FluentIcons.arrow_autofit_up_24_regular,
          color: AppColor.white,
        ),
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

          //conformation Section
          const ConformationPaymentSection(),
        ],
      ),
    );
  }
}
