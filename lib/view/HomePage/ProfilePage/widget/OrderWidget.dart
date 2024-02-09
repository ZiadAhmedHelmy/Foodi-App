import 'package:flutter/material.dart';

import '../../../../Model/Components/CustumText.dart';
import '../../../../Model/Models/OrderModel.dart';
import '../../../../utils/AppColors.dart';
class OrderWidget extends StatelessWidget {
  final List<OrderModel> orderHistory;
  final int index;
   const OrderWidget({super.key, required this.orderHistory, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height/6,
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColor.grey , width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(text: "${orderHistory[index].address}" , fontSize: 20,fontWeight: FontWeight.bold),
            CustomText(text: "${orderHistory[index].orderDate}"),
            Expanded(child: ListView.builder(scrollDirection: Axis.horizontal,itemCount:orderHistory[index].orderDescription?.length , itemBuilder: (context, index2) => CustomText(text: "${orderHistory[index].orderDescription?[index2]["foodName"]} - " , color: AppColor.grey , fontWeight: FontWeight.w600,),)),
            CustomText(text:"Price : ${orderHistory[index].orderPrice} LE" , fontWeight: FontWeight.bold,),
          ],
        ),
      ),
    );
  }
}
