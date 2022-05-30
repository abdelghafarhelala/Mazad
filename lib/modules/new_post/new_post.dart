// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_app/modules/app_cubit/app_cubit.dart';
import 'package:graduation_app/modules/app_cubit/app_states.dart';
import 'package:graduation_app/shared/components/components.dart';

class NewPostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var nameController = TextEditingController();
        var descriptionController = TextEditingController();
        var depositeController = TextEditingController();
        var endDateController = TextEditingController();
        var priceController = TextEditingController();
        var locationController = TextEditingController();
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                defaulttextfield(
                    lable: 'Product Name',
                    controller: nameController,
                    prefix: Icons.wallet_giftcard_outlined,
                    validate: (String val) {
                      if (val.isEmpty) {
                        return 'Product Name can\'t be empty';
                      }
                    },
                    context: context,
                    type: TextInputType.text),
                const SizedBox(
                  height: 15,
                ),
                defaulttextfield(
                    lable: 'Product Price',
                    controller: priceController,
                    prefix: Icons.attach_money,
                    validate: (String val) {
                      if (val.isEmpty) {
                        return 'Product Price can\'t be empty';
                      }
                    },
                    context: context,
                    type: TextInputType.number),
                const SizedBox(
                  height: 15,
                ),
                defaulttextfield(
                    lable: 'Product deposite',
                    controller: depositeController,
                    prefix: Icons.monetization_on,
                    validate: (String val) {
                      if (val.isEmpty) {
                        return 'Product deposite can\'t be empty';
                      }
                    },
                    context: context,
                    type: TextInputType.number),
                const SizedBox(
                  height: 15,
                ),
                defaulttextfield(
                    lable: 'Location',
                    prefix: Icons.location_on,
                    validate: (String val) {
                      if (val.isEmpty) {
                        return 'Location can\'t be empty';
                      }
                    },
                    context: context,
                    controller: locationController,
                    type: TextInputType.text),
                const SizedBox(
                  height: 15,
                ),
                defaulttextfield(
                    controller: endDateController,
                    lable: 'End Date',
                    prefix: Icons.date_range,
                    validate: (String val) {
                      if (val.isEmpty) {
                        return 'End Date can\'t be empty';
                      }
                    },
                    context: context,
                    type: TextInputType.number,
                    ontap: () {
                      showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2030))
                          .then((value) {
                        endDateController.text = value!.toLocal().toString();
                      });
                    }),
                const SizedBox(
                  height: 15,
                ),
                defaulttextfield(
                    lable: 'Description',
                    prefix: Icons.description,
                    validate: (String val) {
                      if (val.isEmpty) {
                        return 'Description can\'t be empty';
                      }
                    },
                    context: context,
                    controller: depositeController,
                    maxLines: 3,
                    type: TextInputType.text),
                const SizedBox(
                  height: 20,
                ),
                defaultButton(onpress: () {}, text: 'Add Product')
              ],
            ),
          ),
        );
      },
    );
  }
}
