// ignore_for_file: prefer_const_constructors

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graduation_app/modules/Register/register.dart';
import 'package:graduation_app/modules/app_cubit/app_cubit.dart';
import 'package:graduation_app/modules/home-layout/home-layout.dart';
import 'package:graduation_app/modules/login/loginCubit/loginCubit.dart';
import 'package:graduation_app/modules/login/loginCubit/loginStates.dart';
import 'package:graduation_app/network/local/cache_helper.dart';
import 'package:graduation_app/shared/components/components.dart';
import 'package:graduation_app/shared/consts/consts.dart';
import 'package:graduation_app/shared/style/color.dart';
import 'package:hexcolor/hexcolor.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppLoginCubit(),
      child: BlocConsumer<AppLoginCubit, AppLoginStates>(
        listener: (context, state) {
          if (state is AppLoginSuccessState) {
            if (state.model!.status!) {
              CacheHelper.saveData(
                      key: "token", value: state.model!.data!.token)
                  .then((value) {
                token = state.model!.data!.token!;
                AppCubit.get(context).getAllProducts();
                AppCubit.get(context).getFavorites();
                AppCubit.get(context).getUserData();
                navigateAndFinsh(context, HomeLayout());
              });
            } else {
              showToast(text: state.model!.message, state: ToastStates.error);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
              // resizeToAvoidBottomInset: false,
              // appBar: AppBar(
              //   backgroundColor: Colors.white,
              //   centerTitle: true,
              //   elevation: 0,
              //   title: Text(
              //     'Login',
              //     style: TextStyle(fontSize: 24, color: Colors.black),
              //   ),
              // ),
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
            child: Container(
              // color: Colors.white,
              child: SingleChildScrollView(
                child: Form(
                  onChanged: () {},
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 330,
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
                              height: 200,
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
                              height: 150,
                              child: Container(
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/light-2.png'))),
                              ),
                            ),
                            Positioned(
                              right: 40,
                              top: 40,
                              width: 80,
                              height: 150,
                              child: Container(
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/clock.png'))),
                              ),
                            ),
                            Positioned(
                              top: 190,
                              left: 165,
                              child: Text(
                                'Login',
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
                            SizedBox(
                              height: 20.0,
                            ),
                            // SizedBox(
                            //   height: 40.0,
                            // ),
                            defaulttextfield(
                                lable: 'Enter your email address',
                                prefix: Icons.person,
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
                                lable: 'Enter your password',
                                prefix: Icons.lock,
                                isSecure: AppLoginCubit.get(context).isPass,
                                validate: (String value) {
                                  if (value.isEmpty) {
                                    return 'password must be filled ';
                                  }
                                },
                                suffix: AppLoginCubit.get(context).suffix,
                                suffixPressed: () {
                                  AppLoginCubit.get(context)
                                      .changePasswordVisibilty();
                                },
                                context: context,
                                type: TextInputType.visiblePassword,
                                controller: passwordController),
                            SizedBox(
                              height: 30,
                            ),
                            ConditionalBuilder(
                              condition: state is! AppLoginLoadingState,
                              fallback: (context) =>
                                  Center(child: CircularProgressIndicator()),
                              builder: (context) => defaultButton(
                                radius: 8.0,
                                onpress: () {
                                  if (formKey.currentState!.validate()) {
                                    AppLoginCubit.get(context).userLogin(
                                        email: emailController.text,
                                        password: passwordController.text);
                                  }
                                },
                                text: 'LOGIN',
                                isUpper: true,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(FontAwesomeIcons.facebook),
                                  color: Colors.black38,
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(FontAwesomeIcons.google),
                                  color: Colors.black38,
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    FontAwesomeIcons.twitter,
                                  ),
                                  color: Colors.black38,
                                ),
                                // IconButton(onPressed: (){}, icon:Icon( Icons.facebook_outlined,) )
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Text(
                                    'Don\'t have an account ?',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    navigateTo(context, RegisterScreen());
                                  },
                                  child: Text(
                                    'REGISTER',
                                    style: TextStyle(
                                        color: defaultColor, fontSize: 20),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      )
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
