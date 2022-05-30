// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_app/models/productDataModel.dart';
import 'package:graduation_app/modules/app_cubit/app_cubit.dart';
import 'package:graduation_app/modules/app_cubit/app_states.dart';
import 'package:graduation_app/modules/products/products.dart';
import 'package:graduation_app/shared/components/components.dart';
import 'package:graduation_app/shared/style/color.dart';

class ProductDataScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<String> imgList = [
      'https://apollo-ireland.akamaized.net/v1/files/7n9f417r4gpc2-EG/image;s=644x461;olx-st/_1_.jpg',
      'https://apollo-ireland.akamaized.net/v1/files/qoapr8rg9t83-EG/image;s=644x461;olx-st/_3_.jpg',
      'https://apollo-ireland.akamaized.net/v1/files/a9ex7hkgtasa-EG/image;s=644x461;olx-st/_4_.jpg'
    ];
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ConditionalBuilder(
              condition: state is! AppGetProductDataLoadingState,
              fallback: (context) =>
                  const Center(child: CircularProgressIndicator()),
              builder: (context) {
                return Scaffold(
                  appBar: AppBar(
                    title: Title(color: Colors.black, child: Text('Products')),
                  ),
                  body: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
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
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                buildData(
                                    context: context,
                                    productData: AppCubit.get(context)
                                        .productdata
                                        ?.data),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.favorite_border),
                                        iconSize: 40,
                                      ),
                                    ),
                                    Expanded(
                                      child: IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.comment_outlined),
                                        iconSize: 40,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: OutlinedButton(
                                            onPressed: () {
                                              navigateTo(
                                                  context, ProductsScreen());
                                            },
                                            child: Text('Start Biding'))),
                                    SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              });
        });
  }
}

Widget buildData(
        {required context, required ProductDataDetails? productData}) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //name and number of bids
        Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Text('Name : ',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 18)),
                  Text(productData!.pName!,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 18, color: defaultColor)),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Text('Number of Bids : ',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 18)),
                  Text(productData.numBids!.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 18, color: defaultColor)),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        //deposit and location
        Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Text('Deposite : ',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 18)),
                  Text(productData.deposite!.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 18, color: defaultColor)),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Text('Location : ',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 18)),
                  Text(productData.location!.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 18, color: defaultColor)),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        //old and new price
        Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Text('Start Price : ',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 18)),
                  Text(productData.oldPrice!.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 18, color: defaultColor)),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Text('New Price : ',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 18)),
                  Text(productData.newPrice!.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 18, color: defaultColor)),
                ],
              ),
            ),
          ],
        ),
        //start date
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Text('Start Date : ',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 18)),
            Text(productData.startDate!,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 18, color: defaultColor)),
          ],
        ),
        //end date
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Text('End Date : ',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 18)),
            Text(productData.endDate!,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 18, color: defaultColor)),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        //description
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('Description : ',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 18,
                    )),
            Expanded(
              child: Text(
                productData.description!,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 18, color: defaultColor),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
