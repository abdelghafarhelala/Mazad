// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_app/modules/app_cubit/app_cubit.dart';
import 'package:graduation_app/modules/app_cubit/app_states.dart';
import 'package:graduation_app/shared/components/components.dart';
import 'package:graduation_app/shared/style/color.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var nameController = TextEditingController();
    var emailController = TextEditingController();
    var phoneController = TextEditingController();
    var ageController = TextEditingController();
    var crditController = TextEditingController();
    var casheController = TextEditingController();
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = AppCubit.get(context).profileModel;
        var isVisable = true;
        if (AppCubit.get(context).profileModel != null) {
          emailController.text = model!.profileData!.email!;
          nameController.text = model.profileData!.name!;
          ageController.text = model.profileData!.age!.toString();
          phoneController.text = model.profileData!.phone!.toString();
          if (model.profileData!.bankAccount != null)
            crditController.text = model.profileData!.bankAccount!;
          if (model.profileData!.vodafoneAccount != null)
            casheController.text = model.profileData!.vodafoneAccount!;
        }

        return ConditionalBuilder(
          condition: state is AppGetUserDataSuccessState,
          fallback: (context) => Center(child: CircularProgressIndicator()),
          builder: (context) => SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTcGJegujCz3neLg3btfiVRfmV4dg52BBd38g&usqp=CAU'),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.grey[300],
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.camera_alt_sharp),
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    // Text(
                    //   "Flutter Developer",
                    //   style: TextStyle(
                    //       fontSize: 15,
                    //       color: Colors.blueGrey[200],
                    //       letterSpacing: 2.5,
                    //       fontWeight: FontWeight.bold,
                    //       fontFamily: "Source Sans Pro"),
                    // ),
                    // SizedBox(
                    //   height: 20,
                    //   width: 200,
                    //   child: Divider(
                    //     color: Colors.grey,
                    //   ),
                    // ),
                    SizedBox(
                      height: 15,
                    ),
                    defaulttextfield(
                        isEnabled: isVisable,
                        lable: 'Name',
                        prefix: Icons.person,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'Name must be filled';
                          }
                          return null;
                        },
                        context: context,
                        type: TextInputType.text,
                        controller: nameController),
                    SizedBox(
                      height: 30.0,
                    ),

                    defaulttextfield(
                        isEnabled: isVisable,
                        lable: 'Email',
                        prefix: Icons.email,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'Email must be filled';
                          }
                          return null;
                        },
                        context: context,
                        type: TextInputType.emailAddress,
                        controller: emailController),
                    SizedBox(
                      height: 30.0,
                    ),

                    defaulttextfield(
                        isEnabled: isVisable,
                        lable: 'Phone',
                        prefix: Icons.phone,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'Phone must be filled';
                          }
                          return null;
                        },
                        context: context,
                        type: TextInputType.phone,
                        controller: phoneController),
                    SizedBox(
                      height: 30.0,
                    ),
                    defaulttextfield(
                        isEnabled: isVisable,
                        lable: 'Age',
                        prefix: Icons.date_range,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'Age must be filled';
                          }
                          return null;
                        },
                        context: context,
                        type: TextInputType.phone,
                        controller: ageController),
                    SizedBox(
                      height: 30.0,
                    ),
                    if (AppCubit.get(context)
                            .profileModel!
                            .profileData!
                            .bankAccount !=
                        null)
                      defaulttextfield(
                          isEnabled: isVisable,
                          lable: 'Bank account',
                          prefix: Icons.account_balance_wallet_outlined,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return ' Bank account must be filled';
                            }
                            return null;
                          },
                          context: context,
                          type: TextInputType.phone,
                          controller: crditController),
                    SizedBox(
                      height: 30.0,
                    ),
                    if (AppCubit.get(context)
                            .profileModel!
                            .profileData!
                            .vodafoneAccount !=
                        null)
                      defaulttextfield(
                          isEnabled: isVisable,
                          lable: 'Vodafone cache',
                          prefix: Icons.phone,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'vodafone Cashe must be filled';
                            }
                            return null;
                          },
                          context: context,
                          type: TextInputType.phone,
                          controller: casheController),

                    SizedBox(
                      height: 10.0,
                    ),

                    defaultButton(
                      text: 'Edit profile',
                      onpress: () {
                        if (formKey.currentState!.validate()) {
                          AppCubit.get(context).UpdateUserData(
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.hashCode,
                            age: ageController.hashCode,
                            bankAccount: crditController.text,
                            vodafoneAccount: casheController.text,
                          );
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
