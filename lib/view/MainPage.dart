import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:providerapp/Model/Components/CustomTextForm.dart';
import 'package:providerapp/Model/Components/CustumText.dart';
import 'package:providerapp/Model/widgets/BannerFoodCard.dart';
import 'package:providerapp/Model/widgets/FoodCardWidget.dart';
import 'package:providerapp/utils/AppColors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:providerapp/view/ProductPage.dart';
import 'package:providerapp/view/SearchPage.dart';
import 'package:providerapp/viewModel/Bloc/product/product_cubit_bloc.dart';
import 'package:providerapp/viewModel/data/SharedKeys.dart';
import 'package:providerapp/viewModel/data/SharedPrefrences.dart';
import 'package:quickalert/models/quickalert_animtype.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../viewModel/Bloc/BottomNavigationCubit/NavigationBloc.dart';

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
        child: Scaffold(
          backgroundColor: AppColor.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: AppColor.white,
            toolbarHeight: 200,
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
                                                 .foodList[cubit.currentIndex],
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
                          child: Icon(Icons.grade_outlined , color: AppColor.white,),
                        ),
                      ),
                    ],
                  ),
                  CustomText(
                    text:
                        "What would you\n like to eat ${LocalData.getData(key: SharedKey.userName)} ?",
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ),
          ),
          body: cubit.foodList == null
              ? Center(
                  child: Lottie.asset("assets/Loading.json"),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                      tag: "SearchBar",

                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                          child: CustomTextField( icon: const Icon(Icons.search),controller:search , hintText: "Search...", keyboardType: TextInputType.none , readOnly: true , onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage(),));
                          },),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: BlocConsumer<ProductCubit, ProductCubitState>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          return CarouselSlider.builder(
                              itemCount: cubit.carouselItems.length,
                              itemBuilder: (context, index, realIndex) {
                                return BannerCard(
                                    item: cubit.carouselItems[realIndex]);
                              },
                              options: CarouselOptions(
                                height: 300,
                                enlargeCenterPage: true,
                                autoPlay: true,
                                aspectRatio: 16 / 9,
                                autoPlayCurve: Curves.fastOutSlowIn,
                                enableInfiniteScroll: false,
                                autoPlayAnimationDuration:
                                    const Duration(milliseconds: 800),
                                viewportFraction: 0.8,
                              ));
                        },
                      ),
                    ),
                    const SizedBox(height: 20),

                    // See MORE Categories !!!!!
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CustomText(
                          text: "Categories",
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
                                  Icons.arrow_circle_right_outlined,
                                  color: AppColor.orange,
                                )
                              ],
                            )),
                      ],
                    ),

                    BlocConsumer<ProductCubit, ProductCubitState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        return Expanded(
                          flex: 2,
                          child: ListView.separated(
                            itemCount: cubit.foodList.length,
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return FoodCard(
                                  item: cubit.foodList[index],
                                  onTap: () {
                                    cubit.changeIndex(index);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ProductPage(
                                            item: cubit
                                                .foodList[cubit.currentIndex],
                                          ),
                                        ));
                                  });
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              width: 16,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
