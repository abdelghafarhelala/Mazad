// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_app/modules/app_cubit/app_cubit.dart';
import 'package:graduation_app/modules/app_cubit/app_states.dart';
import 'package:graduation_app/modules/product_data/product_data.dart';

import '../../shared/components/components.dart';

class CatagoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        // print(data?.message![0]);
      },
      builder: (context, state) {
        var data = AppCubit.get(context).category;
        return SingleChildScrollView(
          child: Container(
            color: Colors.grey[300],
            child: GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              childAspectRatio: 1 / 1.28,
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              physics: NeverScrollableScrollPhysics(),
              children: List.generate(
                  AppCubit.get(context).category!.message!.length,
                  (index) => (buildCategoryItem(
                      data?.message?[index],
                      AppCubit.get(context).category?.message?[index].kind,
                      context))),
            ),
          ),
        );
      },
    );
  }
}

// onTap: () {
//         navigateTo(context, ProductsScreen());
//       },
// kind image
Widget buildCategoryItem(image, name, context) =>
    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      InkWell(
        onTap: () {
          navigateTo(context, ProductDataScreen());
        },
        child: Card(
            elevation: 5,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Column(
              // alignment: AlignmentDirectional.bottomEnd,
              children: [
                Image(
                  image: NetworkImage('categoryData!.categoryImages'),
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    name,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                )
              ],
            )),
      ),
    ]);
