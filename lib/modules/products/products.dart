// ignore_for_file: prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_app/modules/app_cubit/app_cubit.dart';
import 'package:graduation_app/modules/app_cubit/app_states.dart';
import 'package:graduation_app/modules/models/productModel.dart';
import 'package:graduation_app/modules/product_data/product_data.dart';
import 'package:graduation_app/shared/components/components.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> myMap = {
      'image':
          'https://apollo-ireland.akamaized.net/v1/files/7n9f417r4gpc2-EG/image;s=644x461;olx-st/_1_.jpg',
      'name': 'Mercedes GLC 200',
      'startPrice': '1 000 000',
      'startDate': '1-2022',
      'endDate': '4-2022',
    };
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        // if(state is ShopChangeFavoriteSuccessState)
        //   if(!state.model.status){
        //     showToast(text: state.model.message, state: ToastStates.error);
        //   }
      },
      builder: (context, state) {
        GetAllProducts? data = AppCubit.get(context).product;

        final List<String> imgList = [
          'https://apollo-ireland.akamaized.net/v1/files/7n9f417r4gpc2-EG/image;s=644x461;olx-st/_1_.jpg',
          'https://apollo-ireland.akamaized.net/v1/files/qoapr8rg9t83-EG/image;s=644x461;olx-st/_3_.jpg',
          'https://apollo-ireland.akamaized.net/v1/files/a9ex7hkgtasa-EG/image;s=644x461;olx-st/_4_.jpg'
        ];

        return Scaffold(
          appBar: AppBar(
            title: Text('Products'),
          ),
          body: Center(
            child: ConditionalBuilder(
              condition: true,
              builder: (context) => buildProduct(data, context, imgList, myMap),
              // ignore: prefer_const_constructors
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
          ),
        );
      },
    );
  }

  // HomeModel model,CategoriesModel category
  Widget buildProduct(GetAllProducts? data, context, List imgList, Map myMap) =>
      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 5,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: CarouselSlider(
                items: imgList
                    .map(
                      (e) => Image(
                        image: NetworkImage(e),
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    )
                    .toList(),
                options: CarouselOptions(
                  height: 250,
                  initialPage: 0,
                  viewportFraction: 1,
                  autoPlay: true,
                  autoPlayAnimationDuration: Duration(seconds: 1),
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal,
                  reverse: false,
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'New Products',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                childAspectRatio: 1 / 1.64,
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                physics: NeverScrollableScrollPhysics(),
                children: List.generate(
                  AppCubit.get(context).product!.message!.length,
                  (index) =>
                      buildProductItem(data!.message![index], myMap, context),
                ),
              ),
            )
          ],
        ),
      );
  Widget buildProductItem(Message products, Map myMap, context) => InkWell(
        onTap: () {
          navigateTo(context, ProductDataScreen());
        },
        child: Card(
          elevation: 5,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // color: Colors.red,
                height: 200,
                width: 200,
                child: Image(
                  image: NetworkImage(myMap['image']),
                  height: 200.0,
                  width: 190,
                  // width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      products.pName ?? '',
                      style: TextStyle(fontSize: 14, height: 1.3),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Row(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Text(
                          // '${model.price.round()}',
                          'StartDate: ' + myMap['startDate'],
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.red,
                          ),
                        ),
                        Spacer(),
                        Text(
                          // '${model.price.round()}',
                          'EndDate: ' + myMap['endDate'],
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Text(
                          // '${model.price.round()}',
                          'StartPrice: ' + myMap['startPrice'],
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.blue,
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            // print(model.id);
                            // ShopCubit.get(context).changeFavorites(model.id);
                          },
                          // icon: CircleAvatar(
                          //     radius: 13,
                          //     // backgroundColor: ShopCubit.get(context).favorites[model.id] ?Colors.red[400] :Colors.grey[300],
                          //     child: Icon(
                          //       Icons.favorite_border,
                          //       color: Colors.white,
                          //     ),
                          //     ),

                          icon: myMap['image'] != ''
                              ? Icon(
                                  Icons.favorite,
                                  size: 20,
                                  color: Colors.grey[300],
                                )
                              : Icon(
                                  Icons.favorite,
                                  size: 20,
                                  color: Colors.red,
                                ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
}
