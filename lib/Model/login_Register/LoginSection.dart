import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:providerapp/Model/Components/CustomButton.dart';
import 'package:providerapp/Model/Components/CustomTextForm.dart';
import 'package:providerapp/viewModel/Bloc/auth/auth_cubit_bloc.dart';

import '../../utils/AppColors.dart';
import '../../view/HomePage.dart';
import '../Components/CustumText.dart';
class LoginSection extends StatelessWidget {
  const LoginSection({super.key});

  @override
  Widget build(BuildContext context) {
    return   Padding(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: AuthCubit.get(context).loginKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
         children:  [
          const CustomText(
            text: "Email",
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          CustomTextField(
              controller: AuthCubit.get(context).loginEmail,
              hintText: "me@example.com",
              icon: const Icon(Icons.email_outlined),keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                String emailPattern =
                    r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
                RegExp regex = RegExp(emailPattern);
                if (!regex.hasMatch(value)) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
          ),
          const CustomText(
            text: "Password",
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          CustomTextField(
            controller: AuthCubit.get(context).loginPassword,
            hintText: "password",
            icon: const Icon(Icons.lock_outline_rounded),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              if (value.length < 8) {
                return 'Password must have at least 8 characters';
              }
              return null;
            },
          ),
          CustomButton(text: "Login", color: AppColor.orange,textColor: Colors.white, onTap: (){
                if (AuthCubit.get(context).loginKey.currentState!.validate()) {
                     AuthCubit.get(context).fireAuthLogin().then((value){

                       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                         return HomePage();
                       },));

                       AuthCubit.get(context).clearLoginControllerAndData();
                     }).catchError((error){
                       Fluttertoast.showToast(msg: "Invaild Password Or Email");
                     });

                      }
                }

          ),
        ],
      ),
      ),
    );
  }
}
