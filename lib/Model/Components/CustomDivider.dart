import 'package:flutter/material.dart';
import 'package:providerapp/Model/Components/CustumText.dart';

import '../../utils/AppColors.dart';
class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:[
        const Expanded(
          child: Divider(thickness: 1.5, indent: 40),
        ),
        CustomText(text: " or Login with " , color: AppColor.grey,),
        const Expanded(
          child: Divider(thickness: 1.5, endIndent: 40,),
        ),
      ],
    );
  }
}
