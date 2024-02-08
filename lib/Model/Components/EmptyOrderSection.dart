import 'package:flutter/material.dart';
import 'package:providerapp/utils/AppColors.dart';

import 'CustumText.dart';

class EmptyOrderSection extends StatelessWidget {
  const EmptyOrderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/Images/casual-life-3d-open-mailer-box.png" , width: 200),
          const CustomText(text: "You don't have any orders" , fontWeight: FontWeight.w700, fontSize: 20,),
          const SizedBox(height: 10,),
           CustomText(text: "But You Can quickly order  a lot fot \n delicious food" , fontWeight: FontWeight.w300, fontSize: 16, textAlign: TextAlign.center ,color: AppColor.grey,),
        ],
      ),
    );
  }
}
