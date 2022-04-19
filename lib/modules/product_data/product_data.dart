// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:graduation_app/modules/products/products.dart';
import 'package:graduation_app/shared/components/components.dart';

class ProductDataScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<String> imgList = [
      'https://apollo-ireland.akamaized.net/v1/files/7n9f417r4gpc2-EG/image;s=644x461;olx-st/_1_.jpg',
      'https://apollo-ireland.akamaized.net/v1/files/qoapr8rg9t83-EG/image;s=644x461;olx-st/_3_.jpg',
      'https://apollo-ireland.akamaized.net/v1/files/a9ex7hkgtasa-EG/image;s=644x461;olx-st/_4_.jpg'
    ];
    return Scaffold(
      appBar: AppBar(
        title: Title(color: Colors.black, child: Text('Products')),
      ),
      body: SingleChildScrollView(
        child: Card(
          elevation: 5,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Column(
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
                  children: [
                    SizedBox(
                      height: 200,
                      child: ListView.separated(
                          itemBuilder: (context, index) => buildData(context),
                          separatorBuilder: (context, index) => SizedBox(
                                height: 15,
                              ),
                          itemCount: 5),
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
                    Row(
                      children: [
                        Expanded(
                            child: OutlinedButton(
                                onPressed: () {
                                  navigateTo(context, ProductsScreen());
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
  }
}

Widget buildData(context) => Row(
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Model : ",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 18)),
              Text(' Hondai',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 18))
            ],
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Year : ",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 18)),
              Text(' 2020',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 18))
            ],
          ),
        ),
      ],
    );
