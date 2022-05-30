// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_app/modules/Register/cubit/register_cubit.dart';
import 'package:graduation_app/modules/Register/cubit/register_states.dart';
import 'package:graduation_app/modules/catagories/catigories.dart';
import 'package:graduation_app/shared/components/components.dart';
import 'package:graduation_app/shared/style/color.dart';
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
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              body: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(60),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Center(
                          child: Image.asset(
                        'assets/images/icon_mazad.png',
                        height: 90,
                        width: 400,
                      )),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text('Sign up',
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(
                                color: Colors.black54,
                              )),
                      SizedBox(
                        height: 3.0,
                      ),
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
                          isSecure: true,
                          lable: 'Enter your password',
                          prefix: Icons.lock,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'password must be filled ';
                            }
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
                      defaultButton(
                        radius: 30.0,
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
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('you already have account ?'),
                          TextButton(
                            onPressed: () {
                              navigateTo(context, LoginScreen());
                            },
                            child: Text(
                              'LOGIN',
                              style: TextStyle(color: defaultColor),
                            ),
                          )
                        ],
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
