// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_app/models/get_fav_model.dart';
import 'package:graduation_app/modules/app_cubit/app_cubit.dart';
import 'package:graduation_app/modules/app_cubit/app_states.dart';
import 'package:graduation_app/modules/product_data/product_data.dart';
import 'package:graduation_app/shared/components/components.dart';
import 'package:graduation_app/shared/style/color.dart';
import 'package:hexcolor/hexcolor.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        double screenWidth = MediaQuery.of(context).size.width;

        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: (AppCubit.get(context).fav.isNotEmpty)
              ? ListView.separated(
                  itemBuilder: (context, index) => buildFavoriteItem(
                      AppCubit.get(context).fav[index], context, screenWidth),
                  separatorBuilder: (context, index) => SizedBox(
                        height: 0,
                      ),
                  itemCount: AppCubit.get(context).fav.length)
              : buildNoItems(),
        );
      },
    );
  }
}

//if (AppCubit.get(context).getFavoriteModel!.data!.length == 0)
// buildNoItems()
Widget buildNoItems() => Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 250,
          width: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      'https://img.freepik.com/free-vector/removing-goods-from-basket-refusing-purchase-changing-decision-item-deletion-emptying-trash-online-shopping-app-laptop-user-cartoon-character-vector-isolated-concept-metaphor-illustration_335657-2843.jpg?size=338&ext=jpg&uid=R24960600&ga=GA1.2.1634405249.1648830357'),
                  fit: BoxFit.fill,
                  opacity: .8)),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'The is No Items Here',
          style: TextStyle(fontSize: 20, color: Colors.grey),
        )
      ],
    );

Widget buildFavoriteItem(Fav? fav, context, double screenWidth) => InkWell(
      onTap: () {
        AppCubit.get(context).getProductData(id: fav!.product!.id!);
        navigateTo(
            context,
            ProductDataScreen(
              id: fav.product!.id!,
              model: fav.product,
            ));
      },
      child: SizedBox(
        // padding: EdgeInsets.all(value),
        height: screenWidth >= 384 ? 150 : 168,
        width: double.infinity,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          clipBehavior: Clip.antiAlias,
          elevation: 5,
          child: Row(
            children: [
              Container(
                width: 130,
                height: 160,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(fav
                                ?.product?.productImages?[0].path ??
                            'https://img.freepik.com/free-vector/passenger-airplane-isolated_1284-41822.jpg?size=338&ext=jpg&uid=R24960600&ga=GA1.2.1634405249.1648830357'),
                        fit: BoxFit.contain)),
              ),
              SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      fav?.product?.pName ?? 'Apple Smart Watch',
                      style:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: HexColor('#ff1e74'),
                            borderRadius: BorderRadius.circular(10)),
                        width: 70,
                        height: 30,
                        padding: EdgeInsets.all(3),
                        child: Center(
                            child: Text(
                          'Bids ${fav?.product?.numBids}',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w500),
                        )),
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      if (screenWidth >= 384)
                        Container(
                          decoration: BoxDecoration(
                              color: HexColor('#fcc64a'),
                              borderRadius: BorderRadius.circular(10)),
                          width: 130,
                          height: 30,
                          padding: EdgeInsets.all(3),
                          child: Center(
                              child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'End Date ${fav?.product?.endDate}',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          )),
                        ),
                    ],
                  ),
                  if (screenWidth < 384)
                    SizedBox(
                      height: 5,
                    ),
                  if (screenWidth < 384)
                    Container(
                      decoration: BoxDecoration(
                          color: HexColor('#fcc64a'),
                          borderRadius: BorderRadius.circular(10)),
                      width: 150,
                      height: 25,
                      padding: EdgeInsets.all(3),
                      child: Center(
                          child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'End Date ${fav?.product?.endDate}',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      )),
                    ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'price',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w400),
                          ),

                          // SizedBox(

                          //   height: 4,

                          // ),

                          Text(
                            '${fav?.product?.newPrice}\$',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      IconButton(
                          onPressed: () {
                            AppCubit.get(context)
                                .makeFavorite(productId: fav!.product!.id!);

                            // AppCubit.get(context).changeIconColor();

                            AppCubit.get(context).getFavorites();
                          },
                          icon: Icon(
                            Icons.favorite,
                            size: 35,
                            color: AppCubit.get(context)
                                        .favorites[fav!.product!.id] ??
                                    false
                                ? Colors.red[400]
                                : Colors.grey[300],
                          ))
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
