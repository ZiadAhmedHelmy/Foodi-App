import 'package:flutter/material.dart';
import 'package:providerapp/utils/AppColors.dart';
import 'package:providerapp/Model/Components/CustomDivider.dart';
import 'package:providerapp/Model/login_Register/LoginSection.dart';
import 'package:providerapp/Model/login_Register/RegisterSection.dart';
import 'package:providerapp/Model/Components/AppLogo.dart';

class Login_Register_Page extends StatelessWidget {
  Login_Register_Page({super.key});

  TabBar get _tabBar => TabBar(
        indicatorColor: AppColor.orange,
        indicatorWeight: 4,
        labelColor: AppColor.orange,
        unselectedLabelColor: AppColor.grey,
        indicatorPadding: const EdgeInsets.symmetric(horizontal: 30),
        tabs: const [
          Tab(text: 'Login'),
          Tab(text: 'Sign Up'),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: DefaultTabController(
           length: 2,
            child: Scaffold(
            resizeToAvoidBottomInset: false,
               backgroundColor: AppColor.white,
               appBar: AppBar(
                elevation: 0,
                 toolbarHeight: 250,
                   flexibleSpace: const AppLogo(),
                  backgroundColor: Colors.transparent,
                 bottom: PreferredSize(
                     preferredSize: _tabBar.preferredSize,
                     child: ColoredBox(
                         color: Colors.white,
                         child: _tabBar, // For Switching Between The Login and Register Page
            ),
          ),
        ),
             body: Column(
              children: [
               const Expanded(
              child: TabBarView(
                children: [
                  //Login Section
                    LoginSection(),
                    // Register Section
                    RegisterSection(),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                 // Divider ____________
                  const CustomDivider(),
                 const SizedBox(height: 5,),
                 Container(
                   padding: const EdgeInsets.all(12),
                   decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(8),
                   border: Border.all(
                      width: 1,
                      color: AppColor.grey,
                   ),
                  ),
                     child: Image.asset("assets/Icons/Google logo.png"),
              ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
