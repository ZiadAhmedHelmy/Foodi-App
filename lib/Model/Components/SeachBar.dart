import 'package:flutter/material.dart';

import '../../utils/AppColors.dart';
class SearchFoodBar extends StatelessWidget {
  const SearchFoodBar({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.75,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(width: 2 , color: AppColor.grey)
        ),
        child: SearchBar(
          backgroundColor: MaterialStateProperty.all(AppColor.white),
          elevation: MaterialStateProperty.all(0),
          leading: Icon(Icons.search , color: AppColor.orange,),
          hintText: 'Search',
          hintStyle: MaterialStateProperty.all(TextStyle(color: AppColor.grey , fontWeight: FontWeight.w500 , )),
        ),
      ),
    );
  }
}
