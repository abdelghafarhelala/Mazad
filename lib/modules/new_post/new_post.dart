// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_app/modules/app_cubit/app_cubit.dart';
import 'package:graduation_app/modules/app_cubit/app_states.dart';
import 'package:graduation_app/modules/product_data/product_data.dart';
import 'package:graduation_app/shared/components/components.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

DateTime? dateTime;
var selectedItem;
var nameController = TextEditingController();
var descriptionController = TextEditingController();
var depositeController = TextEditingController();
var endDateController = TextEditingController();
var priceController = TextEditingController();
var locationController = TextEditingController();
String CategoryId = '';

class NewPostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppPostNoteSuccessState) {
          if (state.model!.status == true) {
            showToast(
                text: 'Your Post has been Add Successfully',
                state: ToastStates.success);
          } else {
            showToast(text: 'Can\'t Add your Post ', state: ToastStates.error);
          }
        }
      },
      builder: (context, state) {
        List<String> listOfValue = [
          'vehicles',
          'Electronics',
          'Art',
          'Furniture',
          'Antiques',
          'Business &Industrial',
          'Other'
        ];
        // var postImages = AppCubit.get(context).postImage;
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: defaulttextfield(
                          lable: 'Name',
                          controller: nameController,
                          prefix: Icons.wallet_giftcard_outlined,
                          validate: (String val) {
                            if (val.isEmpty) {
                              return 'Product Name can\'t be empty';
                            }
                          },
                          context: context,
                          type: TextInputType.text),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: defaulttextfield(
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
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: defaulttextfield2(
                          lable: 'Price',
                          controller: priceController,
                          prefix: AssetImage('assets/images/banknotes.png'),
                          validate: (String val) {
                            if (val.isEmpty) {
                              return 'Product Price can\'t be empty';
                            }
                          },
                          context: context,
                          type: TextInputType.number),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: defaulttextfield2(
                          lable: 'deposite',
                          controller: depositeController,
                          prefix: AssetImage('assets/images/banknotes.png'),
                          validate: (String val) {
                            if (val.isEmpty) {
                              return 'Product deposite can\'t be empty';
                            }
                          },
                          context: context,
                          type: TextInputType.number),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
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
                        endDateController.text =
                            DateFormat.yMMMd().format(value!);
                        dateTime = value;
                      });
                    }),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        width: 200,
                        height: 55,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(width: 1, color: Colors.grey)),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            iconSize: 30,
                            autofocus: false,
                            underline: Container(
                              height: 0,
                            ),
                            onTap: () {},
                            isExpanded: true,
                            hint: const Text(
                              'Category',
                              // style: TextStyle(color: Colors.red),
                            ),
                            items: listOfValue.map((String val) {
                              return DropdownMenuItem(
                                value: val,
                                child: Text(
                                  val,
                                ),
                              );
                            }).toList(),
                            onChanged: (val) {
                              AppCubit.get(context).changeListVal(val);
                            },
                            value: AppCubit.get(context).selectedItem,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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
                    controller: descriptionController,
                    maxLines: 3,
                    type: TextInputType.text),
                const SizedBox(
                  height: 10,
                ),
                Text('Upload your Product Images '),
                SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          AppCubit.get(context).countImages();
                          AppCubit.get(context).getImageFromGalley();
                        },
                        child: Container(
                          height: 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.image_rounded),
                              SizedBox(
                                width: 10,
                              ),
                              Text('From Gallery',
                                  style: Theme.of(context).textTheme.caption),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                if (AppCubit.get(context).imageFileList!.isNotEmpty)
                  Container(
                    height: 120,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => buildImage(context,
                            AppCubit.get(context).imageFileList![index]),
                        separatorBuilder: (context, index) => SizedBox(
                              width: 5,
                            ),
                        itemCount: AppCubit.get(context).imageFileList!.length),
                  ),
                SizedBox(
                  height: 10,
                ),
                ConditionalBuilder(
                  condition: state is! AppPostNoteLoadingState,
                  fallback: (context) =>
                      Center(child: CircularProgressIndicator()),
                  builder: (context) => defaultButton(
                      onpress: () {
                        if (AppCubit.get(context).selectedItem == 'vehicles') {
                          CategoryId = '21';
                        } else if (AppCubit.get(context).selectedItem ==
                            'Electronics') {
                          CategoryId = '24';
                        } else if (AppCubit.get(context).selectedItem ==
                            'Art') {
                          CategoryId = '26';
                        } else if (AppCubit.get(context).selectedItem ==
                            'Furniture') {
                          CategoryId = '29';
                        } else if (AppCubit.get(context).selectedItem ==
                            'Antiques') {
                          CategoryId = '32';
                        } else if (AppCubit.get(context).selectedItem ==
                            'Business &Industrial') {
                          CategoryId = '33';
                        } else if (AppCubit.get(context).selectedItem ==
                            'Other') {
                          CategoryId = '34';
                        }

                        AppCubit.get(context).postNoteDataWithoutImage(
                            ProductName: nameController.text,
                            description: descriptionController.text,
                            numOfBids: '0',
                            deposite: depositeController.text,
                            price: int.parse(priceController.text),
                            endDate: dateTime!,
                            categoryId: CategoryId,
                            location: locationController.text);
                      },
                      text: 'Add Product'),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget buildImage(context, XFile image) => Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.amber,
              image: DecorationImage(
                  image: FileImage(File(image.path)), fit: BoxFit.cover)),
        ),
        CircleAvatar(
            radius: 20,
            child: IconButton(
              onPressed: () {
                AppCubit.get(context).removeImage(image);
              },
              icon: Icon(
                Icons.close,
                color: Colors.white,
              ),
            )),
      ],
    );
