import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../utils/AppColors.dart';
class CategorySimmer extends StatelessWidget {
  const CategorySimmer({super.key});

  @override

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Shimmer.fromColors(baseColor: Colors.white38, highlightColor: AppColor.orange, child:ListView.separated(
        itemCount: 8,
        separatorBuilder: (context, index) => const SizedBox(height: 15,),
        itemBuilder: (context, index) {

          if(index == 0){
            return Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColor.grey,
                borderRadius: BorderRadius.circular(20),
              ),
            );
          }

          return Container(
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColor.grey,
              borderRadius: BorderRadius.circular(20),
            ),
          );

        },

      )),
    );
  }
}

