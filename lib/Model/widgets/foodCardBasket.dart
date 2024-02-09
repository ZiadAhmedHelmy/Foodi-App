import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:providerapp/Model/Models/BasketFoodModel.dart';
import 'package:providerapp/viewModel/Bloc/order/order_cubit_bloc.dart';
import '../../utils/AppColors.dart';
import '../Components/CustumText.dart';

class FoodCardBasket extends StatelessWidget {
  final BasketFoodModel item;
  final OrderCubit itemBloc;
  final int index;
  const FoodCardBasket({super.key, required this.item, required this.itemBloc, required this.index ,});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderCubitState>(
        bloc: itemBloc,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color:
                      Colors.grey.withOpacity(0.5), // Adjust the shadow color
                  spreadRadius: 5,
                  blurRadius: 5,
                  offset: const Offset(3, 3), // Adjust the shadow offset
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  // image Product
                  Container(
                    height: 150,
                    width: 120,
                    decoration: BoxDecoration(
                      color: AppColor.lightOrange,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: CachedNetworkImage(
                        imageUrl: item.foodImage!,
                      )
                    ),
                  ),

                  Expanded(
                    child: SizedBox(
                      height: 150,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: item.foodName ?? "burger55",
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),

                          Row(
                            children: [
                              SvgPicture.asset("assets/Icons/Caloris-icon.svg" , width: 30),
                              const SizedBox(width: 8,),
                              CustomText(
                                text: "${item.Calories} Calories" ?? "burger55",
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: AppColor.orange,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: "${item.Price} LE",
                                fontSize: 25,
                                fontWeight: FontWeight.w700,
                              ),

                              CustomText(text:  "X${itemBloc.productCount}" , fontSize: 25, fontWeight: FontWeight.bold,)

                              // Row(
                              //   children: [
                              //     IconButton(
                              //         onPressed: () {
                              //           itemBloc
                              //               .productCountAdd(item.Price! , index);
                              //         },
                              //         icon: Icon(Icons.add)),
                              //     Text("${itemBloc.productCount}"),
                              //     IconButton(
                              //         onPressed: () {
                              //           itemBloc.productCountRemove(
                              //               item.Price!);
                              //         },
                              //         icon: Icon(Icons.remove)),
                              //   ],
                              // )
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
