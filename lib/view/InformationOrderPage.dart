import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:providerapp/Model/Components/CustomButton.dart';
import 'package:providerapp/Model/widgets/ShippingCardInfo.dart';
import 'package:providerapp/view/PaymentPage.dart';
import 'package:quickalert/quickalert.dart';
import '../Model/Components/CustomTextForm.dart';
import '../Model/Components/CustumText.dart';
import '../utils/AppColors.dart';
import '../viewModel/Bloc/UserProfile/profile_cubit.dart';

class InfromationOrderPage extends StatelessWidget {
  InfromationOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = ProfileCubit.get(context);
    return BlocProvider.value(
      value: cubit..getUserShippingInfo(),
      child: Scaffold(
        appBar: AppBar(
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
        body: BlocConsumer<ProfileCubit, ProfileState>(
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
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: CustomButton(
                      text: "add New Order Info",
                      borderColor: AppColor.orange,
                      textColor: AppColor.orange,
                      borderWidth: 3,
                      color: AppColor.white,
                      onTap: () {
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.loading,
                          title: "Shipping Info",
                          text: "",
                          widget: Form(
                              key: cubit.formKey,
                              child: Column(
                                children: [
                                  CustomTextField(
                                    controller: cubit.title,
                                    hintText: "Title",
                                    validator: (p0) {
                                      if (p0!.isEmpty) {
                                        return "empty Feild";
                                      }
                                    },
                                  ),
                                  CustomTextField(
                                      controller: cubit.address,
                                      hintText: "Address",
                                      validator: (p0) {
                                        if (p0!.isEmpty) {
                                          return "empty Feild";
                                        }
                                      }),
                                  CustomTextField(
                                      controller: cubit.phoneNumber,
                                      hintText: "Phone",
                                      validator: (p0) {
                                        if (p0!.isEmpty) {
                                          return "empty Feild";
                                        }
                                      }),
                                  CustomButton(
                                      text: "Add",
                                      color: AppColor.orange,
                                      textColor: AppColor.white,
                                      onTap: () {
                                        if (cubit.formKey.currentState!
                                            .validate()) {
                                          cubit.setUserShippingInfo();
                                          cubit.claerUserShippingInfo();
                                          Navigator.pop(context);
                                        }
                                      })
                                ],
                              )),
                        );
                      }),
                ),
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
