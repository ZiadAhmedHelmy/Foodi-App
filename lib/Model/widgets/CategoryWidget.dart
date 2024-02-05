import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:providerapp/Model/Models/CategoryModel.dart';

import '../../utils/AppColors.dart';
import '../Components/CustumText.dart';
class CategoryCard extends StatelessWidget {

  final CategoryModel item;
  void Function()? onTap;

  CategoryCard({super.key, required this.item , required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(width: 4 ,color: AppColor.orange),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1), // Even lighter shadow
              offset: const Offset(-5, -5), // Top-left shadow
              blurRadius: 10,
              spreadRadius: 2,
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.2), // Darker shadow
              offset: const Offset(5, 5), // Bottom-right shadow
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
              children: [
                Expanded(child:
                 CachedNetworkImage(
                   imageUrl: item.categoryImage!,
                   placeholder: (context, url) => LoadingAnimationWidget.staggeredDotsWave(color: AppColor.orange, size:50),
                 ),
                ),
                CustomText(text: item.categoryName! , fontWeight: FontWeight.bold , fontSize: 16),
                CustomText(text: item.categoryDescription! , color: Colors.deepOrangeAccent , fontWeight: FontWeight.w500 , fontSize: 12, textAlign:TextAlign.center),
              ]
          ),
        ),
      ),
    );
  }
}
