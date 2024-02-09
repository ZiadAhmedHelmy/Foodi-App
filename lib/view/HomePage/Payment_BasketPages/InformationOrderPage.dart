import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:providerapp/Model/Components/CustomButton.dart';
import 'package:providerapp/view/HomePage/Category_SectionPages/widget/ShippingCardInfo.dart';
import 'package:providerapp/view/HomePage/Payment_BasketPages/PaymentPage.dart';
import 'package:providerapp/view/HomePage/Payment_BasketPages/widget/AddShippingInfoButton.dart';
import 'package:providerapp/viewModel/Bloc/order/order_cubit_bloc.dart';
import 'package:quickalert/quickalert.dart';
import '../../../Model/Components/CustomTextForm.dart';
import '../../../Model/Components/CustumText.dart';
import '../../../Model/Components/PopUpWidget.dart';
import '../../../utils/AppColors.dart';
import '../../../viewModel/Bloc/UserProfile/profile_cubit.dart';

class InfromationOrderPage extends StatelessWidget {
  InfromationOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = OrderCubit.get(context);
    return BlocProvider.value(
      value: cubit..getUserShippingInfo(),
      child: Scaffold(
        appBar: AppBar(
          leading: PopUpWidget(icon: FluentIcons.arrow_autofit_up_24_regular , color: AppColor.white,),
          backgroundColor: AppColor.orange,
          elevation: 0,
          title: CustomText(
            text: "Shipping Information",
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColor.white,
          ),
          centerTitle: true,
        ),
        body: BlocConsumer<OrderCubit, OrderCubitState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomText(
                          text: "Shipping Info",
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ],
                  ),
                ),
                if (cubit.shipInfo.isNotEmpty)
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) => const SizedBox(height: 5,),
                      itemCount: cubit.shipInfo.length,
                      itemBuilder: (context, index) {
                        return ShippingCardInfo(item: cubit.shipInfo[index] , index: index, );
                      },
                    ),
                  ),
                const AddShippingInfoButton(),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: CustomButton(
                      text: "Next - Payment Methods",
                      borderColor: AppColor.orange,
                      textColor: AppColor.white,
                      color: AppColor.orange,
                      onTap: () {
                        if(cubit.selectedCardIndex>=0) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentPage(),));
                        }
                        else{
                          Fluttertoast.showToast(msg: "Choose Shipping Info");
                        }

                      }),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
