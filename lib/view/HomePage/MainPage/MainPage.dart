import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:providerapp/Model/Components/CustomTextForm.dart';
import 'package:providerapp/Model/Components/CustumText.dart';
import 'package:providerapp/Model/widgets/FoodCardWidget.dart';
import 'package:providerapp/utils/AppColors.dart';
import 'package:providerapp/view/HomePage/MainPage/widget/IntroFoodSection.dart';
import 'package:providerapp/view/HomePage/MainPage/widget/MainBannerSection.dart';
import 'package:providerapp/view/ProductPage.dart';
import 'package:providerapp/view/SearchPage.dart';
import 'package:providerapp/viewModel/Bloc/product/product_cubit_bloc.dart';
import 'package:providerapp/viewModel/data/SharedKeys.dart';
import 'package:providerapp/viewModel/data/SharedPrefrences.dart';
import 'package:quickalert/models/quickalert_animtype.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../../../viewModel/Bloc/BottomNavigationCubit/NavigationBloc.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = ProductCubit.get(context);
    TextEditingController search = TextEditingController();
    return SafeArea(

      child: BlocProvider.value(
        value: cubit
          ..getAllFoodFire()
          ..getBannerFoodFire(),
        child: BlocConsumer<ProductCubit, ProductCubitState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    return Scaffold(
          backgroundColor: AppColor.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: AppColor.white,
            toolbarHeight: 150,
            flexibleSpace: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: (){
                          QuickAlert.show(
                              context: context,
                              type: QuickAlertType.confirm,
                              text: 'Make The App Choose Your Meal!',
                              title:"Can't Choose Food" ,
                              customAsset: "assets/Images/GuessFood.jpg",
                              confirmBtnText: 'Okey',
                              cancelBtnText: 'No',
                              confirmBtnColor: Colors.orange,
                              onConfirmBtnTap: (){
                                cubit.guessedFoodUser();
                                Navigator.pop(context);
                                QuickAlert.show(
                                    context: context,
                                    type: QuickAlertType.custom,
                                    widget: FoodCard(item: cubit.guessedFood, onTap: (){
                                      cubit.changeIndex(cubit.randomIndex);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ProductPage(
                                              item: cubit
                                                  .introFoodList[cubit.currentIndex],
                                            ),
                                          ));
                                    }),
                                    width: 200,
                                    title: "",
                                    customAsset: "assets/Images/fLogo.png",
                                    headerBackgroundColor: AppColor.orange,
                                    confirmBtnText: "Thanks",
                                    confirmBtnTextStyle: const TextStyle(color: Colors.red) ,
                                    animType: QuickAlertAnimType.slideInDown,
                                    confirmBtnColor: Colors.white

                                );
                              }
                          );
                        },
                        child: Container(
                          width: 50,
                          height: 40,
                          decoration: BoxDecoration(
                              color: AppColor.orange,
                              borderRadius: BorderRadius.circular(8)),
                          child: Icon(FluentIcons.star_12_filled , color: AppColor.white,),
                        ),
                      ),
                    ],
                  ),
                  const CustomText(
                    text:
                    "What would you like to eat ",
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  CustomText(
                    text:
                    "${LocalData.getData(key: SharedKey.userName)} ?",
                    fontSize: 24,
                    color: AppColor.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ),
          ),
          body: cubit.introFoodList.isEmpty
              ? Center(
                  child: LoadingAnimationWidget.bouncingBall(color: AppColor.orange, size: 60),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                      tag: "SearchBar",
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                          child: CustomTextField( icon: const Icon(FluentIcons.search_12_filled),controller:search , hintText: "Search...", keyboardType: TextInputType.none , readOnly: true , onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const SearchPage(),));
                          },),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Expanded(
                      child: MainBannerSection()
                    ),
                    const SizedBox(height: 20),

                    // See MORE Categories !!!!!
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CustomText(
                          text: " Categories",
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        TextButton(
                            onPressed: () {
                              // Navigator.push(context, MaterialPageRoute(builder: (context) => CategoriesPage(),));
                              NavigationCubit.get(context).changeIndex(1);

                            },
                            child: Row(
                              children: [
                                const CustomText(text: "See All"),
                                Icon(
                                  FluentIcons.arrow_circle_right_12_regular,
                                  color: AppColor.orange,
                                )
                              ],
                            )),
                      ],
                    ),
                    const Expanded(
                      flex: 2,
                      child: IntroFoodSection()  ),
                  ],
                ),
        );
  },
),
      ),
    );
  }
}
