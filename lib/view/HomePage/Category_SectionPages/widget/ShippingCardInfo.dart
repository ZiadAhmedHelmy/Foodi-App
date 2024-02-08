import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:providerapp/Model/Components/CustumText.dart';
import 'package:providerapp/Model/Models/ShippingInfoModel.dart';
import 'package:providerapp/utils/AppColors.dart';
import 'package:providerapp/viewModel/Bloc/order/order_cubit_bloc.dart';

import '../../../../viewModel/Bloc/UserProfile/profile_cubit.dart';

class ShippingCardInfo extends StatelessWidget {
  final ShippingInfoModel item;
  final int index;
  const ShippingCardInfo({super.key, required this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    var cubit = OrderCubit.get(context);
    return BlocConsumer<OrderCubit, OrderCubitState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    return InkWell(
      onTap: (){
        cubit.selectInfoFromListInfo(currentIndex: index);
        print(index);
        print(cubit.selectedCardIndex);
        print(cubit.selectedInfo?.title);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child:  Container(
              height: MediaQuery.of(context).size.height / 10,
              width: double.infinity,
              decoration:  BoxDecoration(
                      color: AppColor.white,
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(
                              0.2), // Adjust opacity for a lighter shadow
                          spreadRadius:
                              5, // Increase spreadRadius for a smoother, softer shadow
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                      border: Border.all(color: cubit.selectedCardIndex == index ? AppColor.orange : AppColor.white, width: 2),
                    ),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomText(
                        text: "${item.title}",
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      CustomText(
                        text: "${item.phoneNumber}",
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ],
                  ),
                  CustomText(
                    text: "Address : ${item.address}",
                    color: AppColor.grey,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            
        ),
      ),
    );
  },
);
  }
}
