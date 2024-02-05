import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:providerapp/Model/Components/Add_RemoveBtn.dart';
import 'package:providerapp/Model/Components/CustomButton.dart';
import 'package:providerapp/Model/Components/CustumText.dart';
import 'package:providerapp/Model/Models/FoodModel.dart';
import 'package:providerapp/Model/Models/BasketFoodModel.dart';
import 'package:providerapp/utils/AppColors.dart';
import 'package:providerapp/viewModel/Bloc/ButtonCounterCubit/button_counter_cubit.dart';
import 'package:providerapp/viewModel/Bloc/order/order_cubit_bloc.dart';
import 'package:providerapp/viewModel/Bloc/product/product_cubit_bloc.dart';

class ProductPage extends StatelessWidget {
  final FoodModel item;
  const ProductPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    var OrderC = BasketCubit.get(context);
    var CounterC = ButtonCounterCubit.get(context);
    return BlocProvider(
      create: (context) => BasketCubit(),
      child: Scaffold(
        backgroundColor: AppColor.orange,
        appBar: AppBar(
          backgroundColor: AppColor.orange,
          title: Text(item.foodName!, maxLines: 2),
          elevation: 0,
          actions: const [
            Padding(
              padding: EdgeInsets.all(10),
              child: Icon(Icons.favorite),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              flex: 1,
              child: Center(
                  child: Hero(
                tag: item.foodImage!,
                child: Image.network(
                  item.foodImage!,
                  width: 150,
                ),
              )),
            ),
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16)),
                    color: AppColor.white),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Add_RemoveBtn(),

                    // Product Price
                    CustomText(
                      text: "${item.price} LE",
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),

                    // Product Rate and Calories
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Rate
                        CustomText(
                          text: "${item.foodRate}",
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                        //Calories
                        CustomText(
                            text: "${item.calories} Calories",
                            fontSize: 12,
                            fontWeight: FontWeight.w500)
                      ],
                    ),

                    // Product Details
                    CustomText(
                      text: "About",
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppColor.orange,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColor.lightOrange,
                      decorationThickness: 4,
                    ),

                    // About Product Details
                    CustomText(
                      text:
                          "Lorem ipsum dolor sit amet, consecteturadipiscing elit Ac diam vitaee scelerisque euodio mauris lorem sed vitae. Consecteturmauris dignissim ac consectetur craspharetra",
                      textAlign: TextAlign.start,
                      color: AppColor.grey,
                      fontWeight: FontWeight.w500,
                    ),

                    // Add to basket Cart
                    CustomButton(
                        text: "Add to Basket",
                        color: AppColor.orange,
                        textColor: AppColor.white,
                        btnHeight: 60,
                        icon: Icons.shopping_basket_outlined,
                        iconColor: AppColor.white,
                        onTap: () {
                          if (ButtonCounterCubit.get(context).productCount !=
                              0) {
                            OrderC.readyOrdersList.add(
                              BasketFoodModel(
                                  foodName: item.foodName,
                                  Calories: item.calories,
                                  foodImage: item.foodImage,
                                  Price: item.price?.toDouble(),
                                  foodCount: ButtonCounterCubit.get(context)
                                      .productCount),
                            );
                            OrderC.totalPriceIncrese(item.price!.toDouble(),
                                ButtonCounterCubit.get(context).productCount);
                            Fluttertoast.showToast(
                                msg: "Added to Basket",
                                backgroundColor: Colors.green);
                            CounterC.productCount = 0;
                            Navigator.pop(context);
                          }else{
                           Fluttertoast.showToast(msg: "No Item Picked" , webPosition: "top" , gravity: ToastGravity.BOTTOM , backgroundColor: Colors.red );
                          }
                        }),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
