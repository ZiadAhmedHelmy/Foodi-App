import 'package:elegant_notification/elegant_notification.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:providerapp/Model/Components/CustomButton.dart';
import 'package:providerapp/Model/Components/CustomTextForm.dart';
import 'package:providerapp/Model/Components/CustumText.dart';
import 'package:providerapp/Model/Components/EmptyOrderSection.dart';
import 'package:providerapp/Model/Models/FoodModel.dart';
import 'package:providerapp/Model/widgets/foodCardBasket.dart';
import 'package:providerapp/utils/AppColors.dart';
import 'package:providerapp/view/HomePage/Payment_BasketPages/InformationOrderPage.dart';
import 'package:providerapp/view/HomePage/Payment_BasketPages/widget/BasketMoneySection.dart';
import 'package:providerapp/view/HomePage/Payment_BasketPages/widget/PromoSection.dart';
import 'package:providerapp/viewModel/Bloc/order/order_cubit_bloc.dart';

class BasketScreen extends StatelessWidget {
  late FoodModel item;
  BasketScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var cubit = OrderCubit.get(context);

    // Importnat
    List<OrderCubit> itemBlocs = List.generate(
        OrderCubit.get(context).readyOrdersList.length, (_) => OrderCubit());

    return BlocConsumer<OrderCubit, OrderCubitState>(
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
          body: OrderCubit.get(context).readyOrdersList.isEmpty
              ? const EmptyOrderSection()
              : Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: ListView.builder(
                          itemCount:
                              OrderCubit.get(context).readyOrdersList.length ??
                                  5,
                          scrollDirection: Axis.vertical,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            final item = cubit.readyOrdersList[index];
                            ///// Important!!
                            itemBlocs[index].productCount =
                                OrderCubit.get(context)
                                    .readyOrdersList[index]
                                    .foodCount!;
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Slidable(
                                endActionPane: ActionPane(
                                    motion: const BehindMotion(),
                                    children: [
                                      SlidableAction(
                                        borderRadius: BorderRadius.circular(20),
                                        backgroundColor: Colors.red,
                                        icon: FluentIcons.delete_12_filled,
                                        onPressed: (context) {
                                          OrderCubit.get(context)
                                              .removeProduct(index);
                                          OrderCubit.get(context)
                                              .totalPriceDecrease(
                                                  item.Price!, item.foodCount!);
                                        },
                                        label: "Remove",
                                      )
                                    ]),
                                child: FoodCardBasket(
                                  item: OrderCubit.get(context)
                                      .readyOrdersList[index],
                                  itemBloc: itemBlocs[index],
                                  index: index,
                                ),
                              ),
                            );
                          }),
                    ),
                    const PromoSection(),
                    const SizedBox(
                      height: 15,
                    ),

                    // Confirmation Section / money
                    const BasketMoneySection(),
                  ],
                ),
        );
      },
    );
  }
}
