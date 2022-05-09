// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graduation_app/modules/Register/register.dart';
import 'package:graduation_app/modules/login/loginCubit/loginCubit.dart';
import 'package:graduation_app/modules/login/loginCubit/loginStates.dart';
import 'package:graduation_app/shared/components/components.dart';
import 'package:graduation_app/shared/style/color.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppLoginCubit(),
      child: BlocConsumer<AppLoginCubit, AppLoginStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              // appBar: AppBar(),
              body: Container(
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.all(60),
              // const EdgeInsets.fromLTRB(60, 0, 60, 0),
              child: SingleChildScrollView(
                child: Form(
                  onChanged: () {},
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/images/icon_mazad.png',
                        height: 120,
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Text('Login',
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(
                                color: Colors.black54,
                              )),
                      SizedBox(
                        height: 40.0,
                      ),
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
                        height: 25,
                      ),
                      defaulttextfield(
                          lable: 'Enter your password',
                          prefix: Icons.lock,
                          isSecure: true,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'password must be filled ';
                            }
                          },
                          context: context,
                          type: TextInputType.visiblePassword,
                          controller: passwordController),
                      SizedBox(
                        height: 30,
                      ),
                      defaultButton(
                          radius: 30.0,
                          onpress: () {
                            if (formKey.currentState!.validate()) {
                              AppLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          },
                          text: 'LOGIN',
                          isUpper: true,
                          color: defaultColor),
                      SizedBox(
                        height: 20,
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
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Don\'t have an accout ?'),
                          TextButton(
                            onPressed: () {
                              navigateTo(context, RegisterScreen());
                            },
                            child: Text(
                              'REGISTER',
                              style: TextStyle(color: defaultColor),
                            ),
                          )
                        ],
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
