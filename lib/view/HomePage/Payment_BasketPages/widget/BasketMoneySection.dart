import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:providerapp/viewModel/Bloc/order/order_cubit_bloc.dart';

import '../../../../Model/Components/CustomButton.dart';
import '../../../../Model/Components/CustumText.dart';
import '../../../../utils/AppColors.dart';
import '../InformationOrderPage.dart';

class BasketMoneySection extends StatelessWidget {
  const BasketMoneySection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderCubit, OrderCubitState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColor.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(
                    0, 3), // changes the position of the shadow
              ),
            ],
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(16),
                topLeft: Radius.circular(16)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomText(
                    text: "Subtotal",
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  CustomText(
                      text: "${OrderCubit.totalPrice}",
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: "Delivery",
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  CustomText(
                      text: "20",
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ],
              ),
              Divider(
                color: AppColor.grey,
                thickness: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: "Total",
                    color: AppColor.orange,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  CustomText(
                    text: "${OrderCubit.totalPrice + 20}",
                    color: AppColor.orange,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
              CustomButton(
                  text: "Confirm",
                  color: AppColor.orange,
                  textColor: AppColor.white,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              InfromationOrderPage(),
                        ));
                  })
            ],
          ),
        );
      },
    );
  }
}
