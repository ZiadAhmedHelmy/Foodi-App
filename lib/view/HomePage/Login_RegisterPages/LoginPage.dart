import 'package:flutter/material.dart';
import 'package:providerapp/utils/AppColors.dart';

import 'package:providerapp/Model/Components/AppLogo.dart';

import '../../../viewModel/Bloc/BottomNavigationCubit/NavigationBloc.dart';
import 'login_RegisterSections/LoginSection.dart';
import 'login_RegisterSections/RegisterSection.dart';

class Login_Register_Page extends StatelessWidget {
  const Login_Register_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: AppColor.white,
            appBar: AppBar(
              elevation: 0,
              toolbarHeight: 250,
              flexibleSpace: const AppLogo(),
              backgroundColor: Colors.transparent,
              bottom: PreferredSize(
                preferredSize: NavigationCubit.get(context).tabBar.preferredSize,
                child: ColoredBox(
                  color: Colors.white,
                  child: NavigationCubit.get(context).tabBar, // For Switching Between The Login and Register Page
                ),
              ),
            ),
            body: const Column(
              children: [
                Expanded(
                  child: TabBarView(

                    children: [
                      //Login Section
                      LoginSection(),
                      // Register Section
                      RegisterSection(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}