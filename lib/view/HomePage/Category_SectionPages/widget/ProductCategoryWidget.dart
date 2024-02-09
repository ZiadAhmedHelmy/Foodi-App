import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:providerapp/Model/Models/FoodModel.dart';
import 'package:providerapp/view/HomePage/Category_SectionPages/CategoriesPage.dart';
import 'package:providerapp/viewModel/Bloc/Categories/category_cubit_bloc.dart';

import '../../../../utils/AppColors.dart';
import '../../../ProductPage.dart';
import '../../../../Model/Components/CustumText.dart';
class ProductCategory extends StatelessWidget {

  final FoodModel item;
  final int? index;
  const ProductCategory({super.key,required this.item,required,required this.index , });


  @override
  Widget build(BuildContext context) {
    var categoryCubit = CategoryCubit.get(context);
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: (){
          categoryCubit.currentIndex = index!;
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductPage(
                  item: categoryCubit
                      .productsCategoryList[categoryCubit.currentIndex],
                ),
              ));
        },
        child: Container(
          height: MediaQuery.of(context).size.height/8,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColor.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 3,
                offset: const Offset(0, 3),
              ),
            ],
          ),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width / 3,
                decoration: BoxDecoration(
                  color: AppColor.lightOrange,
                  borderRadius: const BorderRadius.all(Radius.circular(8))
                ),
                child: CachedNetworkImage(
                  imageUrl: item.foodImage! ,
                 placeholderFadeInDuration: const Duration(seconds: 2),
                 placeholder: (context, url) => LoadingAnimationWidget.staggeredDotsWave(color: AppColor.orange, size: 50),
                ),
              ),

              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(text: "${item.foodName}" , fontSize: 13 ,fontWeight: FontWeight.bold, overflow:TextOverflow.ellipsis),

                    Row(
                      children: [
                        SvgPicture.asset("assets/Icons/Caloris-icon.svg" , width: 20),
                        const SizedBox(width: 8,),
                        CustomText(
                          text: "Calories ${item.calories}" ?? "burger55",
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColor.orange,
                        ),
                      ],
                    ),
                     CustomText(text: "${item.price}" , fontSize: 13 , fontWeight: FontWeight.bold,),
                  ],
                ),
              ),

              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                    color: AppColor.orange,
                    borderRadius: BorderRadius.circular(6)
                ),
                child: Icon(FluentIcons.add_12_filled , color: AppColor.white,),
              )

            ],
          ),
        ),
      ),
    );
  }
}
