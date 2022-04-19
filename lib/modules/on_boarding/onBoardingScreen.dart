// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:graduation_app/modules/login/login.dart';
import 'package:graduation_app/network/local/cache_helper.dart';
import 'package:graduation_app/shared/components/components.dart';
import 'package:graduation_app/shared/style/color.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:http/http.dart' as http;

class BoardingModel {
  late final String image;
  late final String title;
  late final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  //const OnBoardingScreen({Key? key}) : super(key: key);
  var boardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
        image:
            'https://media.istockphoto.com/vectors/online-auction-concept-tiny-woman-bidder-buyer-and-auctioneer-bidding-vector-id1317099835?k=20&m=1317099835&s=612x612&w=0&h=Mif2L9QwCH45L3VlpsPExuaLV5own5-iV7tLbLJ3OAI=',
        title: ' MAZAD ',
        body:
            'Now you can bring the auction to your home through MAZAD app . '),

    // BoardingModel(
    //     image:
    //       'https://media.istockphoto.com/vectors/auction-online-vector-concept-for-web-banner-website-page-vector-id1194209555?k=20&m=1194209555&s=612x612&w=0&h=9wfcdXTGfa1e65S0s1hGDl0e03Z_stxJxwtTulhpniw=',
    //     title: ' On Board 2 title',
    //     body: 'On Board 2 body '),
    BoardingModel(
        image:
            'https://media.istockphoto.com/vectors/smartphone-with-auctioneer-holding-gavel-vase-online-auction-internet-vector-id1324749588?k=20&m=1324749588&s=612x612&w=0&h=F8akhLfCQBKuK0QVTbwzp7angBY4YD27AI8uDRzto20=',
        title: ' MAZAD  ',
        body:
            'Will provide you with the ability to display your products for bidding or you are bidding on the products of others.'),
    BoardingModel(
        image:
            'https://media.istockphoto.com/vectors/online-auction-concept-vector-id1327520512?k=20&m=1327520512&s=612x612&w=0&h=8McEouwr8C5kzlL13oaNdxIxttJZAKKQ2kofFeEaJiI=',
        title: ' MAZAD ',
        body:
            'Now you have to start registering in the program to start bidding  '),
  ];

  bool isLast = false;
  void submit() {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value) {
        navigateAndFinsh(context, LoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
                child: Text(
                  'Skip',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: defaultColor,
                  ),
                ),
                onPressed: () {
                  submit();
                }),
          )
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(children: [
            Expanded(
              child: PageView.builder(
                  physics: BouncingScrollPhysics(),
                  controller: boardController,
                  onPageChanged: (int index) {
                    if (index == boarding.length - 1) {
                      setState(() {
                        isLast = true;
                      });
                      print('last');
                    } else {
                      setState(() {
                        isLast = false;
                      });
                    }
                  },
                  itemBuilder: (context, index) =>
                      buildBoardingItem(boarding[index]),
                  itemCount: boarding.length),
            ),
            SizedBox(
              height: 30.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: boarding.length,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    dotHeight: 10.0,
                    dotWidth: 10.0,
                    spacing: 5.0,
                    expansionFactor: 4,
                    activeDotColor: defaultColor,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  backgroundColor: defaultColor,
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      boardController.nextPage(
                        duration: Duration(
                          milliseconds: 740,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: Icon(Icons.arrow_forward_ios),
                )
              ],
            ),
          ]),
        ),
      ),
    );
  }
}

Widget buildBoardingItem(BoardingModel model) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: Center(child: Image(image: NetworkImage('${model.image}')))),
        SizedBox(
          height: 20.0,
        ),
        Center(
          child: Text(
            '${model.title}',
            style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w400),
          ),
        ),
        SizedBox(
          height: 30.0,
        ),
        Text(
          '${model.body}',
          style: TextStyle(fontSize: 16.0),
        ),
      ],
    );
