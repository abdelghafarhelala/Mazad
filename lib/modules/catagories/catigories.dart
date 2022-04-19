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
      listener: (context, state) {},
      builder: (context, state) {
        List<Map<String, dynamic>> list = [
          {
            'image':
                'https://elitetraveler.com/wp-content/uploads/2019/07/Screen-Shot-2019-07-05-at-11.13.50-768x515.png',
            'name': 'Cars'
          },
          {
            'image':
                'https://assets.architecturaldigest.in/photos/60084fc951daf9662c149bb9/1:1/w_768,h_768,c_limit/how-to-clean-gadgets-1366x768.jpg',
            'name': 'Electronics'
          },
          {
            'image':
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR4BRmrtbMXfKyJKuV50Nxipt2Pu_zoBslgZQ&usqp=CAU',
            'name': 'furniture'
          },
          {
            'image':
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQka9DAeXmpzIhJQ0fnzNWTYktG8J6-s5EtHA&usqp=CAU',
            'name': 'antique'
          },
          {
            'image':
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQbNZsGSpfBQ0PohTGCGPKC7A43P_nAvCTDdw&usqp=CAU',
            'name': 'buildings'
          },
          {
            'image': 'https://vistapointe.net/images/other-wallpaper-16.jpg',
            'name': 'other'
          },
        ];
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
                  6, (index) => (buildCategoryItem(list, index, context))),
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
Widget buildCategoryItem(List list, index, context) =>
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
                  image: NetworkImage(list[index]['image']),
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    list[index]['name'],
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
