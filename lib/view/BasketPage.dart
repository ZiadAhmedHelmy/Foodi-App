import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:providerapp/Model/Components/CustomButton.dart';
import 'package:providerapp/Model/Components/CustumText.dart';
import 'package:providerapp/Model/Components/EmptyOrderSection.dart';
import 'package:providerapp/Model/Models/FoodModel.dart';
import 'package:providerapp/Model/widgets/foodCardBasket.dart';
import 'package:providerapp/utils/AppColors.dart';
import 'package:providerapp/view/InformationOrderPage.dart';
import 'package:providerapp/viewModel/Bloc/order/order_cubit_bloc.dart';

class BasketScreen extends StatelessWidget {


  late FoodModel item;
  BasketScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var cubit = BasketCubit.get(context);

    // Importnat
    List<BasketCubit> itemBlocs = List.generate(
        BasketCubit.get(context).readyOrdersList.length,
        (_) => BasketCubit());

    return BlocConsumer<BasketCubit, OrderCubitState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.orange,
        elevation: 0,
        title: CustomText(
          text: "Basket Details",
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColor.white,
        ),
        centerTitle: true,
      ),
      body: BasketCubit.get(context).readyOrdersList.isEmpty ? const EmptyOrderSection() : Column(
        children: [
          Expanded(
            flex: 2,
            child: ListView.builder(
                itemCount:
                    BasketCubit.get(context).readyOrdersList.length ?? 5,
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final item = cubit.readyOrdersList[index];
                  ///// Important!!
                  itemBlocs[index].productCount = BasketCubit.get(context)
                      .readyOrdersList[index]
                      .foodCount!;
                  return Slidable(
                    endActionPane: ActionPane(
                        motion: const BehindMotion(), children:[
                      SlidableAction(
                        borderRadius: BorderRadius.circular(20),
                         backgroundColor: Colors.red,
                          icon: Icons.delete,
                          onPressed: (context) {
                            BasketCubit.get(context).removeProduct(index);
                            BasketCubit.get(context).totalPriceDecrease(item.Price!, item.foodCount!);
                          },
                          label: "Remove",

                      )
                    ] ),

                    child: FoodCardBasket(
                      item: BasketCubit.get(context).readyOrdersList[index],
                      itemBloc: itemBlocs[index],
                      index: index,
                    ),
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: cubit.PromoCode,
                decoration: InputDecoration(
                  fillColor: Colors.transparent,
                  hintText: "Promo Code",
                    prefixIcon:const Icon(Icons.discount),
                    iconColor: AppColor.grey,
                     hoverColor: AppColor.orange,
                     suffixIcon: TextButton(onPressed: (){
                       String currentPromo = cubit.PromoCode.text;
                              if((currentPromo == cubit.Promo) & cubit.promocodeDone){
                                cubit.totalPriceDiscount();
                               Fluttertoast.showToast(msg: "Congrats You got 20% Discount" , backgroundColor: Colors.green ,webPosition: "right" );
                              }
                              else{
                                Fluttertoast.showToast(msg: "Wrong Promo Code");
                              }
                     } ,child: const CustomText(text:"APPLY" ,fontWeight: FontWeight.bold, fontSize: 16,)),
                    enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8))
                    ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColor.orange),
                      borderRadius: const BorderRadius.all(Radius.circular(8))

                  ),

                )

            ),
          ),
          const SizedBox(height: 15,),


          // Confirmation Section / money
          Container(
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
                        text: "${BasketCubit.totalPrice}",
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
                      text: "${BasketCubit.totalPrice + 20}",
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => InfromationOrderPage(),));
                    })
              ],
            ),
          )
        ],
      ),
    );
  },
);
  }
}
