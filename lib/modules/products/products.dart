// ignore_for_file: prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_app/models/get_porduct_category.dart';
import 'package:graduation_app/models/productModel.dart';
import 'package:graduation_app/modules/app_cubit/app_cubit.dart';
import 'package:graduation_app/modules/app_cubit/app_states.dart';
import 'package:graduation_app/modules/favorites/favorites.dart';
import 'package:graduation_app/modules/product_data/product_data.dart';
import 'package:graduation_app/modules/search/search_screen.dart';
import 'package:graduation_app/shared/components/components.dart';
import 'package:hexcolor/hexcolor.dart';

Color? color = Colors.grey[300];

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        // if(state is ShopChangeFavoriteSuccessState)
        //   if(!state.model.status){
        //     showToast(text: state.model.message, state: ToastStates.error);
        //   }
      },
      builder: (context, state) {
        Data? data = AppCubit.get(context).getProductsInCategoryModel?.data;
        double ScreenHeight = MediaQuery.of(context).size.height;
        print('ScreenHeight $ScreenHeight');
        double ratio = 1.5;
        if (ScreenHeight <= 700) {
          ratio = 1.6;
        }
        final List<String> imgList = [
          'https://img.freepik.com/free-vector/gadgets-auction_1284-22060.jpg?size=626&ext=jpg&uid=R24960600&ga=GA1.2.1634405249.1648830357',
          'https://img.freepik.com/free-vector/auction-house-abstract-concept-vector-illustration-residential-commercial-property-auction-buy-sell-assets-online-exclusive-bid-consecutive-biddings-business-auctions-abstract-metaphor_335657-4240.jpg?size=338&ext=jpg&uid=R24960600&ga=GA1.2.1634405249.1648830357',
          'https://img.freepik.com/free-vector/cut-price-bargain-offering-reduced-cost-discount-low-rate-special-promo-scissors-dividing-banknote-crisis-bankruptcy-cheapness-market-vector-isolated-concept-metaphor-illustration_335657-4314.jpg?size=338&ext=jpg&uid=R24960600&ga=GA1.2.1634405249.1648830357'
        ];

        return ConditionalBuilder(
            condition: state is! AppGetProductInCategoryLoadingState,
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()),
            builder: (context) {
              return Scaffold(
                // backgroundColor: Colors.grey[200],
                appBar: AppBar(
                  title: Text(data?.kind ?? ''),
                  actions: [
                    IconButton(
                        onPressed: () {
                          navigateTo(context, SearchScreen(kind: 'product'));
                        },
                        icon: Icon(Icons.search))
                  ],
                ),
                body: Center(
                  child: ConditionalBuilder(
                    condition: state is! AppGetProductInCategoryLoadingState,
                    builder: (context) =>
                        buildProduct(data, context, imgList, ratio),
                    // ignore: prefer_const_constructors
                    fallback: (context) =>
                        Center(child: CircularProgressIndicator()),
                  ),
                ),
              );
            });
      },
    );
  }

  // HomeModel model,CategoriesModel category
  Widget buildProduct(Data? data, context, List imgList, double retio) =>
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
                  height: 180,
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
                  Row(
                    children: [
                      Text(
                        'New ',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        ' Products',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: HexColor('#410adf')),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            if (AppCubit.get(context).productCat.length > 0)
              Container(
                child: GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  childAspectRatio: 1 / retio,
                  mainAxisSpacing: 1,
                  crossAxisSpacing: 1,
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  physics: NeverScrollableScrollPhysics(),
                  children: List.generate(
                    AppCubit.get(context).productCat.length,
                    (index) => buildProductItem(
                        AppCubit.get(context)
                            .getProductsInCategoryModel!
                            .data!
                            .productcategory![index],
                        context),
                  ),
                ),
              ),
            if (AppCubit.get(context).productCat.length == 0) buildNoItems(),
          ],
        ),
      );
  Widget buildProductItem(Productcategory products, context) => InkWell(
        onTap: () {
          AppCubit.get(context).getProductData(id: products.id!);
          navigateTo(
              context,
              ProductDataScreen(
                model: products,
                id: products.id!,
              ));
        },
        child: Card(
          elevation: 8,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          // color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // color: Colors.red,
                height: 120,
                width: 224,
                child: Image(
                  image: NetworkImage(products.productImages?[0].path ??
                      'https://img.freepik.com/free-vector/passenger-airplane-isolated_1284-41822.jpg?size=338&ext=jpg&uid=R24960600&ga=GA1.2.1634405249.1648830357'),
                  height: 120.0,
                  width: 190,
                  // width: double.infinity,
                  fit: BoxFit.contain,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      products.pName ?? '',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 100,
                          height: 30,
                          decoration: BoxDecoration(
                              color: HexColor('#ff1e74'),
                              borderRadius: BorderRadius.circular(8)),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  // '${model.price.round()}',
                                  '  Bids: ' + products.numBids!,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 145,
                          height: 30,
                          decoration: BoxDecoration(
                              color: HexColor('#fcc64a'),
                              borderRadius: BorderRadius.circular(8)),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  // '${model.price.round()}',
                                  '  EndDate: ' + products.endDate!,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'price',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w500),
                              ),
                              // SizedBox(
                              //   height: 4,
                              // ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      products.newPrice == 0
                                          ? '${products.newPrice} EGP'
                                          : '${products.oldPrice} EGP',
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        IconButton(
                            onPressed: () {
                              AppCubit.get(context)
                                  .makeFavorite(productId: products.id ?? 1);
                              // AppCubit.get(context).changeIconColor();
                              AppCubit.get(context).getFavorites();
                            },
                            icon: Icon(
                              Icons.favorite,
                              size: 25,
                              color: AppCubit.get(context)
                                          .favorites[products.id] ??
                                      false
                                  ? Colors.red[400]
                                  : Colors.grey[300],
                            ))
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
