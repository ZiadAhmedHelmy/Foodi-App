import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:providerapp/Model/Components/CustumText.dart';
import 'package:providerapp/Model/Models/FoodModel.dart';
import 'package:providerapp/utils/AppColors.dart';
class FoodCard extends StatelessWidget {


  final FoodModel item;
  void Function()? onTap;

  FoodCard({super.key, required this.item ,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: MediaQuery.of(context).size.height / 4,
          width: MediaQuery.of(context).size.width*0.6,
          decoration: BoxDecoration(
             color: AppColor.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5), // Adjust the shadow color
                spreadRadius: 5,
                blurRadius: 5,
                offset: const Offset(3, 3), // Adjust the shadow offset
              ),

            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    width: 250,
                    height: MediaQuery.of(context).size.height / 6,
                   decoration: BoxDecoration(
                     color: AppColor.lightOrange,
                     borderRadius: BorderRadius.circular(8),
                   ),


                    child: Center(
                      child: Hero(
                          tag:item.foodImage! ,
                          child: CachedNetworkImage(
                            imageUrl: item.foodImage!,
                            placeholder: (context, url) =>  LoadingAnimationWidget.staggeredDotsWave(
                              color: Colors.white,
                              size: 100,
                            ),
                          ),
                      ),
                    ),
                  ),
                ),
                CustomText(text:item.foodName ?? "burger55" , fontSize:16 , fontWeight: FontWeight.w500,overflow:TextOverflow.ellipsis , ),

                CustomText(text: "${item.calories} Calories" ?? "55" , color: AppColor.orange, fontSize: 12 , fontWeight: FontWeight.w500,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(text:"${item.price} LE" ?? "55" ,fontSize: 16,fontWeight: FontWeight.w700, ),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColor.orange,
                        borderRadius: BorderRadius.circular(6)
                      ),
                      child: Icon(FluentIcons.add_12_filled , color: AppColor.white,),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
