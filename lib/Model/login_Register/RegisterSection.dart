import 'package:flutter/material.dart';
import 'package:providerapp/Model/Components/CustomButton.dart';
import 'package:providerapp/Model/Components/CustomTextForm.dart';
import 'package:providerapp/Model/Components/CustumText.dart';
import 'package:providerapp/viewModel/Bloc/auth/auth_cubit_bloc.dart';

import '../../utils/AppColors.dart';
class RegisterSection extends StatelessWidget {
  const RegisterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: AuthCubit.get(context).registerKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment:MainAxisAlignment.spaceEvenly,
          children: [
            const CustomText(
              text: "Full Name",
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            CustomTextField(

                controller: AuthCubit.get(context).userName,
                hintText: "name",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Name';
                  }
                  if (value.length < 8) {
                    return 'your name must have at least 8 characters';
                  }
                  return null;
                },
                icon: const Icon(Icons.email_outlined),keyboardType: TextInputType.emailAddress
            ),
            const CustomText(
              text: "Email",
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            CustomTextField(
              controller: AuthCubit.get(context).email,
              hintText: "me@example.com",
              icon: const Icon(Icons.lock_outline_rounded),
              keyboardType: TextInputType.emailAddress,
              validator:  (value) {
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
              controller: AuthCubit.get(context).password,
              hintText: "password",
              icon: const Icon(Icons.lock_outline_rounded),
              keyboardType:TextInputType.text,
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
            CustomButton(text: "Sign Up", color: AppColor.orange,textColor: Colors.white, onTap: (){
              if (AuthCubit.get(context).registerKey.currentState!.validate()) {
                AuthCubit.get(context).signUpWithFire().then((value){
                  AuthCubit.get(context).clearRegisterControllers() ;
                });

              }
            }),
          ],
        ),
      ),
    );
  }
}
