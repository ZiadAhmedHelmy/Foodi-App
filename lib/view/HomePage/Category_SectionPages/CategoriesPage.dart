
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:providerapp/Model/widgets/CategoryWidget.dart';
import 'package:providerapp/view/HomePage/Category_SectionPages/Products_CategoryPage.dart';
import 'package:providerapp/viewModel/Bloc/Categories/category_cubit_bloc.dart';
import '../../../Model/Components/CustumText.dart';
import '../../../utils/AppColors.dart';
class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    var categoryCubit = CategoryCubit.get(context);

    return BlocProvider.value(
      value: categoryCubit..getAllCategoriesFire(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.orange,
          elevation: 0,
          title: CustomText(
            text: "Categories",
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColor.white,
          ),
          centerTitle: true,
        ),
        body: BlocConsumer<CategoryCubit, CategoryCubitState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                itemCount: categoryCubit.categoryList.length,
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,), itemBuilder: (context, index) {
                return CategoryCard(item: categoryCubit.categoryList[index] , onTap: (){
                  categoryCubit.currentIndex = index;
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  ProductsCategoryPage(),));
                },);
              },),
            );
          },
        ),

      ),
    );
  }
}

