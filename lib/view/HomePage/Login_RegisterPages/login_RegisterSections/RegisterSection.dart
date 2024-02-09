import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:providerapp/Model/Components/CustomButton.dart';
import 'package:providerapp/Model/Components/CustomTextForm.dart';
import 'package:providerapp/Model/Components/CustumText.dart';
import 'package:providerapp/viewModel/Bloc/ButtonCounterCubit/button_counter_cubit.dart';
import 'package:providerapp/viewModel/Bloc/auth/auth_cubit_bloc.dart';

import '../../../../utils/AppColors.dart';

class RegisterSection extends StatelessWidget {
  const RegisterSection({super.key});

  @override
  Widget build(BuildContext context) {
    var buttonCubit = ButtonCounterCubit.get(context);
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: AuthCubit.get(context).registerKey,
        child: ListView(
          children: [


            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                    icon: const Icon(FluentIcons.text_12_filled),
                    keyboardType: TextInputType.emailAddress),
              ],
            ),



            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomText(
                  text: "Email",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                CustomTextField(
                  controller: AuthCubit.get(context).email,
                  hintText: "me@example.com",
                  icon: const Icon(FluentIcons.person_12_filled),
                  keyboardType: TextInputType.emailAddress,
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
              ],
            ),



            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomText(
                  text: "Password",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                BlocConsumer<ButtonCounterCubit, ButtonCounterState>(
                  listener: (context, state) {
                    // TODO: implement listener
                  },
                  builder: (context, state) {
                    return CustomTextField(
                      controller: AuthCubit.get(context).password,
                      obscureText: buttonCubit.isShowenPassLogin,
                      suffixIcon: IconButton(
                        onPressed: () {
                          buttonCubit.showPassWord();
                        },
                        icon:buttonCubit.isShowenPassLogin==true ? const Icon(FluentIcons.lock_closed_key_20_regular) : const Icon(FluentIcons.lock_open_20_regular) ,
                      ),
                      hintText: "password",
                      icon: const Icon(FluentIcons.password_16_filled),
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 8) {
                          return 'Password must have at least 8 characters';
                        }
                        return null;
                      },
                    );
                  },
                ),
              ],
            ),


            const SizedBox(height: 20,),
            CustomButton(
                text: "Sign Up",
                color: AppColor.orange,
                textColor: Colors.white,
                onTap: () {
                  if (AuthCubit.get(context)
                      .registerKey
                      .currentState!
                      .validate()) {
                    AuthCubit.get(context).signUpWithFire().then((value) {
                      AuthCubit.get(context).clearRegisterControllers();
                    });
                  }
                }),
          ],
        ),
      ),
    );
  }
}
