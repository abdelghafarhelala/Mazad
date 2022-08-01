import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_app/models/category_search_model.dart';
import 'package:graduation_app/models/product_search.dart';
import 'package:graduation_app/modules/app_cubit/app_cubit.dart';
import 'package:graduation_app/modules/app_cubit/app_states.dart';
import 'package:graduation_app/modules/product_data/product_data.dart';
import 'package:graduation_app/shared/components/components.dart';
import 'package:hexcolor/hexcolor.dart';

class SearchScreen extends StatelessWidget {
  final String kind;
  const SearchScreen({Key? key, required this.kind}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.black),
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: HexColor('#FFFFFF'),
              statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.dark),
          backgroundColor: HexColor('#FFFFFF'),
          title: Title(
              color: Colors.black,
              child: const Text(
                'Search',
                style: TextStyle(color: Colors.black),
              )),
        ),
        body: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            double screenWidth = MediaQuery.of(context).size.width;
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: searchController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), label: Text('Search')),
                    onChanged: (value) {
                      print('value value value value $value');
                      print('value value value value $kind');
                      if (value == '') {
                        AppCubit.get(context).clearList();
                      } else {
                        AppCubit.get(context)
                            .getSearch(text: value, kind: kind);
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (AppCubit.get(context).search.isNotEmpty ||
                      AppCubit.get(context).searchCat.isNotEmpty)
                    Expanded(
                      child: ListView.separated(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,

                        // physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => kind == 'product'
                            ? buildSearchProductItem(
                                AppCubit.get(context)
                                    .productSearchModel
                                    ?.data?[index],
                                context,
                                screenWidth)
                            : buildSearchCategoryItem(AppCubit.get(context)
                                .categorySearchModel
                                ?.data?[index]),
                        separatorBuilder: (context, index) => SizedBox(
                          height: 5,
                        ),
                        itemCount: kind == 'product'
                            ? AppCubit.get(context)
                                .productSearchModel!
                                .data!
                                .length
                            : AppCubit.get(context)
                                .categorySearchModel!
                                .data!
                                .length,
                      ),
                    )
                ],
              ),
            );
          },
        ));
  }
}

Widget buildSearchProductItem(
        SearchProduct? data, context, double screenWidth) =>
    InkWell(
      onTap: () {
        navigateTo(
            context,
            ProductDataScreen(
              id: data!.id!,
              model: data,
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
                        image: NetworkImage(data?.productImages?[0].path ??
                            'https://img.freepik.com/free-vector/passenger-airplane-isolated_1284-41822.jpg?size=338&ext=jpg&uid=R24960600&ga=GA1.2.1634405249.1648830357'),
                        fit: BoxFit.cover)),
              ),
              const SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      data?.pName ?? 'Apple Smart Watch',
                      style: const TextStyle(
                          fontSize: 19, fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(
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
                        padding: const EdgeInsets.all(3),
                        child: Center(
                            child: Text(
                          'Bids ${data?.numBids}',
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w500),
                        )),
                      ),
                      const SizedBox(
                        width: 7,
                      ),
                      if (screenWidth >= 384)
                        Container(
                          decoration: BoxDecoration(
                              color: HexColor('#fcc64a'),
                              borderRadius: BorderRadius.circular(10)),
                          width: 130,
                          height: 30,
                          padding: const EdgeInsets.all(3),
                          child: Center(
                              child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'End Date ${data?.endDate}',
                                  style: const TextStyle(
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
                    const SizedBox(
                      height: 5,
                    ),
                  if (screenWidth < 384)
                    Container(
                      decoration: BoxDecoration(
                          color: HexColor('#fcc64a'),
                          borderRadius: BorderRadius.circular(10)),
                      width: 150,
                      height: 25,
                      padding: const EdgeInsets.all(3),
                      child: Center(
                          child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'End Date ${data?.endDate}',
                              style: const TextStyle(
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
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'price',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w400),
                          ),

                          // SizedBox(

                          //   height: 4,

                          // ),

                          Text(
                            '${data?.newPrice}\$',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      IconButton(
                          onPressed: () {
                            AppCubit.get(context)
                                .makeFavorite(productId: data!.id!);

                            // AppCubit.get(context).changeIconColor();

                            AppCubit.get(context).getFavorites();
                          },
                          icon: Icon(
                            Icons.favorite,
                            size: 35,
                            color: AppCubit.get(context).favorites[data!.id!] ??
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

Widget buildSearchCategoryItem(CategorySearch? category) => InkWell(
      onTap: () {},
      child: SizedBox(
        height: 140,
        width: double.infinity,
        child: Card(
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              Container(
                height: 100,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: NetworkImage(category?.categoryImages != ''
                      ? category!.categoryImages!
                      : 'https://img.freepik.com/free-vector/passenger-airplane-isolated_1284-41822.jpg?size=338&ext=jpg&uid=R24960600&ga=GA1.2.1634405249.1648830357'),
                  fit: BoxFit.cover,
                )),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                category?.kind ?? '',
                style:
                    const TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
      ),
    );
