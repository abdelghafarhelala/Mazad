// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, must_be_immutable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_app/modules/Register/cubit/register_cubit.dart';
import 'package:graduation_app/modules/Register/cubit/register_states.dart';
import 'package:graduation_app/modules/app_cubit/app_cubit.dart';
import 'package:graduation_app/modules/catagories/catigories.dart';
import 'package:graduation_app/modules/home-layout/home-layout.dart';
import 'package:graduation_app/network/local/cache_helper.dart';
import 'package:graduation_app/shared/components/components.dart';
import 'package:graduation_app/shared/consts/consts.dart';
import 'package:graduation_app/shared/style/color.dart';
import 'package:hexcolor/hexcolor.dart';
import '../login/login.dart';

class RegisterScreen extends StatelessWidget {
  //const  RegisterScreen({Key? key}) : super(key: key);

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var eController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var ageController = TextEditingController();
  var bankController = TextEditingController();
  var cashController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  late var age;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            if (state.model?.status == true) {
              CacheHelper.saveData(
                      key: "token", value: state.model?.data!.token)
                  .then((value) {
                token = state.model?.data?.token;
                AppCubit.get(context).getUserData();
                showToast(
                    text: 'Registered Successfully',
                    state: ToastStates.success);
                navigateAndFinsh(context, HomeLayout());
                print(state.model?.data!.name);
              });
            } else {
              showToast(text: state.model?.message, state: ToastStates.error);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
              body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
              // For Android.
              // Use [light] for white status bar and [dark] for black status bar.
              statusBarIconBrightness: Brightness.dark,
              statusBarColor: HexColor('#410adf'),
              // For iOS.
              // Use [dark] for white status bar and [light] for black status bar.
              statusBarBrightness: Brightness.dark,
            ),
            child: SingleChildScrollView(
              child: Container(
                // color: Colors.white,
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 220,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/image.png'),
                                fit: BoxFit.fill)),
                        child: Stack(
                          children: [
                            Positioned(
                              // top: 50,
                              left: 30,
                              width: 80,
                              height: 130,
                              child: Container(
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/light.png'))),
                              ),
                            ),
                            Positioned(
                              left: 140,
                              width: 80,
                              height: 100,
                              child: Container(
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/light-2.png'))),
                              ),
                            ),
                            Positioned(
                              right: 40,
                              top: 30,
                              width: 50,
                              height: 120,
                              child: Container(
                                // width: 70,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/clock.png'))),
                              ),
                            ),
                            Positioned(
                              top: 120,
                              left: 165,
                              child: Text(
                                'Sign Up',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                        color: Colors.white, fontSize: 30),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            defaulttextfield(
                                lable: 'Name',
                                prefix: Icons.person,
                                validate: (String value) {
                                  if (value.isEmpty) {
                                    return 'Name must be filled ';
                                  }
                                },
                                context: context,
                                type: TextInputType.name,
                                controller: nameController),
                            SizedBox(
                              height: 10.0,
                            ),
                            defaulttextfield(
                                lable: 'Enter your email address',
                                prefix: Icons.email,
                                validate: (String value) {
                                  if (value.isEmpty) {
                                    return 'email address must be filled ';
                                  }
                                },
                                context: context,
                                type: TextInputType.emailAddress,
                                controller: emailController),
                            SizedBox(
                              height: 10,
                            ),
                            defaulttextfield(
                                isSecure: RegisterCubit.get(context).isPass,
                                lable: 'Enter your password',
                                prefix: Icons.lock,
                                validate: (String value) {
                                  if (value.isEmpty) {
                                    return 'password must be filled ';
                                  }
                                },
                                suffix: RegisterCubit.get(context).suffix,
                                suffixPressed: () {
                                  RegisterCubit.get(context)
                                      .changePasswordVisibilty();
                                },
                                context: context,
                                type: TextInputType.visiblePassword,
                                controller: passwordController),
                            SizedBox(
                              height: 10,
                            ),
                            defaulttextfield(
                                lable: 'Phone',
                                prefix: Icons.phone,
                                validate: (String value) {
                                  if (value.isEmpty) {
                                    return 'Phone must be filled ';
                                  }
                                },
                                context: context,
                                type: TextInputType.phone,
                                controller: phoneController),
                            SizedBox(
                              height: 10.0,
                            ),
                            defaulttextfield(
                              lable: 'Age',
                              prefix: Icons.date_range_outlined,
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return 'Age must be filled ';
                                }
                              },
                              context: context,
                              type: TextInputType.number,
                              controller: ageController,
                              //  ontap: () {
                              //   showDatePicker(
                              //           context: context,
                              //           initialDate: DateTime.now(),
                              //           firstDate: DateTime(1950),
                              //           lastDate: DateTime(2030))
                              //       .then((value) {
                              //     ageController.text = value!.toLocal().toString();
                              //   });
                              // }
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            defaulttextfield(
                              lable: 'Bank account',
                              prefix: Icons.account_balance_wallet_outlined,
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return ' Bank account must be filled ';
                                }
                              },
                              context: context,
                              type: TextInputType.number,
                              controller: bankController,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            defaulttextfield(
                                lable: 'Vodafone Cash',
                                prefix: Icons.contact_phone_outlined,
                                validate: (String value) {
                                  if (value.isEmpty) {
                                    return 'Vodafone cash must be filled ';
                                  }
                                },
                                context: context,
                                type: TextInputType.phone,
                                controller: cashController),
                            SizedBox(
                              height: 15.0,
                            ),
                            ConditionalBuilder(
                              condition: state is! RegisterLoadingState,
                              fallback: (context) =>
                                  Center(child: CircularProgressIndicator()),
                              builder: (context) => defaultButton(
                                radius: 10.0,
                                onpress: () {
                                  if (formKey.currentState!.validate()) {
                                    RegisterCubit.get(context).userRegister(
                                        email: emailController.text,
                                        password: passwordController.text,
                                        phone: phoneController.text,
                                        bankAccount: bankController.text,
                                        vodafoneCash: cashController.text,
                                        age: ageController.text,
                                        name: nameController.text);
                                  }
                                },
                                text: 'Sign up',
                                isUpper: true,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'you already have account ?',
                                  style: TextStyle(fontSize: 20),
                                ),
                                TextButton(
                                  onPressed: () {
                                    navigateTo(context, LoginScreen());
                                  },
                                  child: Text(
                                    'LOGIN',
                                    style: TextStyle(
                                        color: defaultColor, fontSize: 20),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ));
        },
      ),
    );
  }
}
