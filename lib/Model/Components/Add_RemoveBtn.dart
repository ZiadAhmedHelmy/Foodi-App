import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:providerapp/Model/Components/CustumText.dart';

import '../../utils/AppColors.dart';
import '../../viewModel/Bloc/ButtonCounterCubit/button_counter_cubit.dart';
import '../../viewModel/Bloc/order/order_cubit_bloc.dart';
class Add_RemoveBtn extends StatelessWidget {
  const Add_RemoveBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: AppColor.lightGrey),
      child: Padding(
        padding: const EdgeInsets.all(5),

        // Add Or Remove product Quantity
        child: BlocConsumer<ButtonCounterCubit, ButtonCounterState>(
          listener: (context, state) {},
          builder: (context, state) {
            return SizedBox(
              width: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                      backgroundColor: AppColor.white,
                      radius: 16,
                      child: IconButton(
                          onPressed: () {
                            ButtonCounterCubit.get(context)
                                .productCountRemove();
                          },
                          icon: const Icon(
                            Icons.remove,
                            color: Colors.black,
                            size: 16,
                          ))),
                  CustomText(text: "${ButtonCounterCubit.get(context).productCount}",fontWeight: FontWeight.w500,),
                  CircleAvatar(
                      backgroundColor: AppColor.orange,
                      radius: 16,
                      child: IconButton(
                          onPressed: () {
                            ButtonCounterCubit.get(context)
                                .productCountAdd();
                          },
                          icon: const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 16,
                          ))),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
