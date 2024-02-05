import 'package:flutter/material.dart';
import 'package:providerapp/Model/Components/CustumText.dart';
import 'package:providerapp/Model/Models/ProductBanarModel.dart';
import 'package:providerapp/utils/AppColors.dart';
class BannerCard extends StatelessWidget {


  final BannerModel item;
  const BannerCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
           gradient: AppColor.orangeG1,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomText(text: item.foodName ?? "empty", fontSize: 24, color: AppColor.white,fontWeight: FontWeight.w600, ),
                Card(color: AppColor.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12 , vertical: 5),
                    child: CustomText(text: "${item.foodPrice ?? "20"}LE" , color: AppColor.orange, fontSize:16 , fontWeight: FontWeight.w600,),
                  ),),
              ],
            ),
            Image.network( item.urlImage ?? "https://www.google.com.eg/url?sa=i&url=https%3A%2F%2Fwww.pngegg.com%2Fen%2Fsearch%3Fq%3Derror&psig=AOvVaw1XyPHaS9rXfjeF8sLQXAuI&ust=1703548580642000&source=images&cd=vfe&opi=89978449&ved=0CBEQjRxqFwoTCOCU9pKjqYMDFQAAAAAdAAAAABAD", width: 100,),
          ],
        ),
      ),
    );
  }
}
