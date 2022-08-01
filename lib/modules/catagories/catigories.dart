// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_app/modules/app_cubit/app_cubit.dart';
import 'package:graduation_app/modules/app_cubit/app_states.dart';
import 'package:graduation_app/modules/products/products.dart';
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
        return ConditionalBuilder(
          condition: State is! AppGetCategoryDataLoadingState,
          fallback: (context) => Center(child: CircularProgressIndicator()),
          builder: (context) => SingleChildScrollView(
            child: Container(
              // color: Colors.grey[300],
              child: ConditionalBuilder(
                condition: AppCubit.get(context).cat.length > 0,
                fallback: (context) =>
                    Center(child: CircularProgressIndicator()),
                builder: (context) => GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  childAspectRatio: 1 / 1.2,
                  mainAxisSpacing: 1,
                  crossAxisSpacing: 1,
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  physics: NeverScrollableScrollPhysics(),
                  children: List.generate(
                      AppCubit.get(context).cat.length,
                      (index) => (buildCategoryItem(
                          data?.message?[index].categoryImages,
                          AppCubit.get(context).category?.message?[index].kind,
                          AppCubit.get(context).category?.message?[index].id,
                          context))),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget buildCategoryItem(image, name, id, context) =>
    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      InkWell(
        onTap: () {
          AppCubit.get(context).getProductInCategory(categoryId: id);
          navigateTo(context, ProductsScreen());
        },
        child: Card(
            elevation: 5,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Column(
              children: [
                Image(
                  // image: AssetImage('assets/images/a.jpeg'),
                  image: NetworkImage(image ??
                      'https://img.freepik.com/free-vector/video-conference-remote-working-flat-illustration-screen-laptop-with-group-colleagues-people-conn_88138-548.jpg?size=626&ext=jpg&uid=R24960600&ga=GA1.2.1634405249.1648830357'),
                  fit: BoxFit.fill,
                  width: double.infinity,
                  height: 160,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          name,
                          style: Theme.of(context).textTheme.bodyText1,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            )),
      ),
    ]);
