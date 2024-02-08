import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Model/widgets/BannerFoodCard.dart';
import '../../viewModel/Bloc/product/product_cubit_bloc.dart';
class MainBannerSection extends StatelessWidget  {
  const MainBannerSection({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = ProductCubit.get(context);
    return BlocConsumer<ProductCubit, ProductCubitState>(
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
    );
  }
}
