import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:providerapp/Model/Components/CustumText.dart';
import 'package:providerapp/utils/AppColors.dart';
import 'package:providerapp/viewModel/Bloc/UserProfile/profile_cubit.dart';
class PaymentMethodCard extends StatelessWidget {

 final String text;
 final int index;
   PaymentMethodCard({super.key , required this.text, required this.index});

  @override
  Widget build(BuildContext context) {
    var cubit = ProfileCubit.get(context);
    return BlocConsumer<ProfileCubit, ProfileState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    return InkWell(
      onTap: (){
         cubit.selectPaymentMethod(currentIndex: index);
         print(cubit.paymentList[cubit.selectPaymentIndex]);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: MediaQuery.of(context).size.height / 10,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(10),
            border:  Border.all(color: cubit.selectPaymentIndex == index ? AppColor.orange : AppColor.white, width: 2),
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
          ),
          child: Center(child: CustomText(text: text, fontWeight: FontWeight.bold , fontSize: 18 ,)),
        ),
      ),
    );
  },
);
  }
}
