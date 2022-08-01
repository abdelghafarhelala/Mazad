// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_app/models/productDataModel.dart';
import 'package:graduation_app/models/productModel.dart';
import 'package:graduation_app/modules/app_cubit/app_cubit.dart';
import 'package:graduation_app/modules/app_cubit/app_states.dart';
import 'package:graduation_app/modules/comment/comment_screen.dart';
import 'package:graduation_app/modules/products/products.dart';
import 'package:graduation_app/shared/components/components.dart';
import 'package:graduation_app/shared/consts/consts.dart';
import 'package:graduation_app/shared/style/color.dart';
import 'package:graduation_app/shared/style/themes.dart';
import 'package:hexcolor/hexcolor.dart';

bool isMazad = false;

var bidController = TextEditingController();

class ProductDataScreen extends StatelessWidget {
  final model;
  final int id;

  const ProductDataScreen({Key? key, required this.model, required this.id})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(listener: (context, state) {
      if (state is AppMakeMazadSuccessState) {
        if (state.Model!.status!) {
          showToast(text: state.Model!.msg, state: ToastStates.success);
          AppCubit.get(context).getProductData(id: model.id);
          AppCubit.get(context).MakeComment(
              userId: 88, text: bidController.text, productId: (model.id));
          subscribeToTopic(model.id.toString());
          sendNotify(
              AppCubit.get(context).profileModel!.message!.name!,
              'Has bis ${bidController.text} \$',
              model.id.toString(),
              'abdo',
              '1000');
          getMessage();
        } else {
          showToast(text: state.Model!.msg, state: ToastStates.error);
        }
      }
    }, builder: (context, state) {
      var modell = AppCubit.get(context).productdata?.data;
      double screenHight = MediaQuery.of(context).size.height;
      return ConditionalBuilder(
          condition: state is! AppGetProductDataLoadingState,
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
          builder: (context) {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: HexColor('#410adf'),
              appBar: AppBar(
                centerTitle: true,
                iconTheme: IconThemeData(color: Colors.white),
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: HexColor('#410adf'),
                    statusBarIconBrightness: Brightness.light,
                    statusBarBrightness: Brightness.light),
                backgroundColor: HexColor('#410adf'),
                title: Title(
                    color: Colors.black,
                    child: Text(
                      'Products',
                      style: TextStyle(color: Colors.white),
                    )),
              ),
              body: AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle(
                  // For Android.
                  // Use [light] for white status bar and [dark] for black status bar.
                  statusBarIconBrightness: Brightness.dark,
                  statusBarColor: HexColor('#410adf'),
                  // For iOS.
                  // Use [dark] for white status bar and [light] for black status bar.
                  statusBarBrightness: Brightness.dark,
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      width: double.infinity,
                      height: 130,
                      child: Card(
                        elevation: 5,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: CarouselSlider(
                          items: modell!.productImages!
                              .map(
                                (e) => Image(
                                  image: NetworkImage(e.path!),
                                  fit: BoxFit.fill,
                                  width: double.infinity,
                                ),
                              )
                              .toList(),
                          options: CarouselOptions(
                            height: 130,
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
                    ),
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        SizedBox(
                          height: 35,
                          width: double.infinity,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: IconButton(
                              onPressed: () {
                                AppCubit.get(context)
                                    .makeFavorite(productId: modell.id ?? 1);
                                // AppCubit.get(context).changeIconColor();
                                AppCubit.get(context).getFavorites();
                              },
                              icon: Icon(
                                Icons.favorite,
                                color: AppCubit.get(context)
                                            .favorites[modell.id] ??
                                        false
                                    ? Colors.red[400]
                                    : Colors.grey[300],
                                size: 35,
                              )),
                        )
                      ],
                    ),
                    Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) =>
                              buildP(context, modell),
                          separatorBuilder: (context, index) => SizedBox(
                                height: 0,
                              ),
                          itemCount: 1),
                    )
                  ],
                ),
              ),
            );
          });
    });
  }
}

Widget buildDialog(context, var model) {
  return Dialog(
    insetAnimationCurve: Curves.linearToEaseOut,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    child: Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
          padding: EdgeInsets.all(20),
          height: 300,
          width: 450,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              Text('Enter the price you want to bid',
                  style: Theme.of(context).textTheme.headline1),
              const SizedBox(
                height: 30,
              ),
              defaulttextfield(
                  lable: 'Your bid price',
                  prefix: Icons.money_rounded,
                  validate: (String val) {
                    if (val.isEmpty) {
                      return 'You must enter a number';
                    }
                  },
                  context: context,
                  type: TextInputType.number,
                  controller: bidController),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                      child: defaultButton(
                          onpress: () {
                            AppCubit.get(context).changeValue();
                            Navigator.pop(context);
                          },
                          text: 'the value is correct',
                          radius: 10)),
                ],
              ),
            ],
          ),
        ),
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.close))
      ],
    ),
  );
}

Widget buildP(context, model) => Container(
      padding: EdgeInsets.all(15),
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppCubit.get(context).isDark ? darkColor : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  model?.pName ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                height: 50,
                width: 130,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 2, color: HexColor('#ff1e74'))),
                child: Center(
                  child: Text(
                    model?.newPrice != '0'
                        ? model?.newPrice + ' EGP'
                        : model?.oldPrice + ' EGP' ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: HexColor('#ff1e74'),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: HexColor('#ff1e74'),
                    borderRadius: BorderRadius.circular(10)),
                width: 90,
                height: 30,
                padding: EdgeInsets.all(3),
                child: Center(
                    child: Text(
                  'Bids : ${model?.numBids}',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w300),
                )),
              ),
              SizedBox(
                width: 7,
              ),
              Container(
                decoration: BoxDecoration(
                    color: HexColor('#fcc64a'),
                    borderRadius: BorderRadius.circular(10)),
                width: 180,
                height: 30,
                padding: EdgeInsets.all(3),
                child: Center(
                    child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'End Date : ${model?.endDate}',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w300),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                )),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          // Container(
          //   height: 1,
          //   width: double.infinity,
          //   color: Colors.grey[300],
          // ),
          // SizedBox(
          //   height: 10,
          // ),
          Row(
            children: [
              Text('Product', style: Theme.of(context).textTheme.headline2),
              SizedBox(
                width: 5,
              ),
              Text(
                'Details',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w700,
                  color: HexColor('#410adf'),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 3,
          ),
          Container(
            height: 2,
            width: 190,
            color: HexColor('#ff1e74'),
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Text('start date :',
                  style: Theme.of(context).textTheme.headline3),
              SizedBox(
                width: 5,
              ),
              Text('${model?.startDate}',
                  style: Theme.of(context).textTheme.caption),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 1,
            width: double.infinity,
            color: Colors.grey[300],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text('start Price :',
                  style: Theme.of(context).textTheme.headline3),
              SizedBox(
                width: 5,
              ),
              Text('${model?.oldPrice} EGP',
                  style: Theme.of(context).textTheme.caption),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 1,
            width: double.infinity,
            color: Colors.grey[300],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text('Location :', style: Theme.of(context).textTheme.headline3),
              SizedBox(
                width: 5,
              ),
              Text(model?.location ?? '',
                  style: Theme.of(context).textTheme.caption),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 1,
            width: double.infinity,
            color: Colors.grey[300],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text('Description :',
                  style: Theme.of(context).textTheme.headline3),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: Text(
                  model?.description ?? '',
                  style: Theme.of(context).textTheme.caption,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),

          if (isMazad == false)
            defaultButton(
                onpress: () {
                  showDialog(
                    context: context,
                    builder: (context) => buildDialog(context, model),
                  );
                },
                text: 'Start Bid',
                isUpper: false,
                radius: 10),

          if (isMazad == true)
            Column(
              children: [
                Text(
                  'Total Price ${bidController.text}',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.red,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 20,
                ),
                defaultButton(
                    onpress: () {
                      // showDialog(
                      //   context: context,
                      //   builder: (context) =>
                      //       buildDialog(context, model),
                      // );
                      AppCubit.get(context).makeMazad(
                          value: int.parse(bidController.text),
                          productId: model!.id!);
                      isMazad = false;
                    },
                    text: 'Bid Now',
                    isUpper: false,
                    radius: 10),
              ],
            ),
          SizedBox(
            height: 8,
          ),
          ConditionalBuilder(
            condition: State is! AppGetAllCommentsSuccessState,
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()),
            builder: (context) => defaultButton(
                onpress: () {
                  // showDialog(
                  //   context: context,
                  //   builder: (context) =>
                  //       buildDialog(context, model),
                  // );
                  AppCubit.get(context).getAllComments(productId: model!.id);
                  navigateTo(
                      context,
                      CommentsScreen(
                        productId: model!.id,
                      ));
                },
                text: 'Comments',
                isUpper: false,
                radius: 10),
          ),
          // SizedBox(height: 10,),
        ],
      ),
    );
