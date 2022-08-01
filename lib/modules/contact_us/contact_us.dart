import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_social_button/flutter_social_button.dart';
import 'package:graduation_app/modules/app_cubit/app_cubit.dart';
import 'package:graduation_app/modules/app_cubit/app_states.dart';
import 'package:graduation_app/shared/components/components.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        // if (state is AppPostContactSuccessState) {
        //   showToast(text: state.model.errorMessage, state: ToastStates.success);
        // }
        // elseif(AppPostContactErrorState) {
        //   showToast(
        //       text: 'لم يتم ارسال البيانات برجاء المحاوله مره اخري',
        //       state: ToastStates.error);
        // }
      },
      builder: (context, state) {
        var emailController = TextEditingController();
        var nameController = TextEditingController();
        var phoneController = TextEditingController();
        var detailsController = TextEditingController();

        var formKey = GlobalKey<FormState>();
        return Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const Text(
                        'كيف يمكننا ان نساعدك',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      defaulttextfield(
                          lable: 'الاسم',
                          controller: nameController,
                          prefix: Icons.person,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'يجب ان تدخل الاسم';
                            }
                          },
                          context: context,
                          type: TextInputType.text),
                      const SizedBox(
                        height: 15,
                      ),
                      defaulttextfield(
                          lable: 'الهاتف',
                          controller: phoneController,
                          prefix: Icons.person,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'يجب ان تدخل رقم الهاتف';
                            }
                          },
                          context: context,
                          type: TextInputType.phone),
                      const SizedBox(
                        height: 15,
                      ),
                      defaulttextfield(
                          lable: 'البريد الالكتروني',
                          controller: emailController,
                          prefix: Icons.email_outlined,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'يجب ان تدخل البريد الالكتروني';
                            }
                          },
                          context: context,
                          type: TextInputType.emailAddress),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: detailsController,
                        maxLines: 5,
                        decoration: const InputDecoration(
                          hintText: 'رسالتك',
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ConditionalBuilder(
                        condition: true,
                        fallback: (context) =>
                            const Center(child: LinearProgressIndicator()),
                        builder: (context) => defaultButton(
                            onpress: () {
                              // if (formKey.currentState!.validate()) {
                              //   if (EmailValidator.validate(
                              //       emailController.text)) {
                              //     AppCubit.get(context).contactUsData(
                              //       message: detailsController.text,
                              //       email: emailController.text,
                              //       name: nameController.text,
                              //       phone: phoneController.text,
                              //     );
                              //   } else {
                              //     showToast(
                              //         text: 'email is incorrect',
                              //         state: ToastStates.error);
                              //   }
                              // } else {}
                            },
                            text: 'ارسال'),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              color: Colors.grey,
                              height: 1,
                            ),
                          ),
                          Text(
                            ' Our Social media Links',
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                          Expanded(
                            child: Container(
                              color: Colors.grey,
                              height: 1,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FlutterSocialButton(
                              mini: true,
                              onTap: () {
                                _launchUrl(context, '');
                              },
                              buttonType: ButtonType.facebook),
                          FlutterSocialButton(
                              mini: true,
                              onTap: () {
                                _launchUrl(context, '');
                              },
                              buttonType: ButtonType.twitter),
                          FlutterSocialButton(
                              mini: true,
                              onTap: () {
                                _launchUrl(context, 'https://mail.google.com/');
                              },
                              buttonType: ButtonType.google),
                          FlutterSocialButton(
                              mini: true,
                              onTap: () {
                                _launchUrl(
                                    context, 'https://www.linkedin.com/');
                              },
                              buttonType: ButtonType.linkedin),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

void _launchUrl(context, url) async {
  if (!await launchUrl(Uri.parse(url))) throw 'Could not launch $url';
}
