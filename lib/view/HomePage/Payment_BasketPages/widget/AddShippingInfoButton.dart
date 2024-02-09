import 'package:flutter/material.dart';
import 'package:providerapp/viewModel/Bloc/order/order_cubit_bloc.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../../../../Model/Components/CustomButton.dart';
import '../../../../Model/Components/CustomTextForm.dart';
import '../../../../utils/AppColors.dart';
class AddShippingInfoButton extends StatelessWidget {
  const AddShippingInfoButton({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = OrderCubit.get(context);
    return  Padding(
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
    );
  }
}
