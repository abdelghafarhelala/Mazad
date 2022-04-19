// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:graduation_app/modules/bids/bids.dart';
import 'package:graduation_app/modules/favorites/favorites.dart';
import 'package:graduation_app/modules/new_post/new_post.dart';
import 'package:graduation_app/modules/profile/profile.dart';

import '../../shared/components/components.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              'User Name',
              style: TextStyle(color: Colors.black),
            ),
            accountEmail: Text(
              'example@gmail.com',
              style: TextStyle(color: Colors.black),
            ),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                  'https://img.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg?w=996&t=st=1648830402~exp=1648831002~hmac=23bb5c012cffe2b975c10240fb7aa2f906cd61fc0e106b73ae52d85af1159554',
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            decoration: BoxDecoration(color: Colors.white),
          ),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text(
              '+20 1005360624',
              style: TextStyle(color: Colors.black),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text(
              'favorites',
              style: TextStyle(color: Colors.black),
            ),
            onTap: () {
              navigateTo(context, FavoritesScreen());
            },
          ),
          ListTile(
            leading: Icon(Icons.gavel),
            title: Text(
              'Bids',
              style: TextStyle(color: Colors.black),
            ),
            onTap: () {
              navigateTo(context, BidsScreen());
            },
          ),
          ListTile(
            leading: Icon(Icons.post_add_outlined),
            title: Text(
              'Posts',
              style: TextStyle(color: Colors.black),
            ),
            onTap: () {
              navigateTo(context, NewPostScreen());
            },
          ),
          ListTile(
            leading: Icon(Icons.payments_outlined),
            title: Text(
              'Payment',
              style: TextStyle(color: Colors.black),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text(
              'Profile',
              style: TextStyle(color: Colors.black),
            ),
            onTap: () {
              navigateTo(context, ProfileScreen());
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text(
              'Settings',
              style: TextStyle(color: Colors.black),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.logout_outlined,
              color: Colors.red,
            ),
            title: Text(
              'Logout',
              style: TextStyle(color: Colors.red),
            ),
            onTap: () {},
          ),
        ],
      ),
      // child: Padding(
      //   padding: const EdgeInsets.all(20),
      //   child: Column(
      //     children: [
      //       Row(
      //         children: [
      //           Column(
      //             children: [
      //               CircleAvatar(
      //                 radius: 55,
      //                 backgroundImage: NetworkImage(
      //                   'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTcGJegujCz3neLg3btfiVRfmV4dg52BBd38g&usqp=CAU',
      //                 ),
      //               ),
      //             ],
      //           ),
      //           SizedBox(
      //             width: 15,
      //           ),
      //           Column(
      //             children: [
      //               Row(
      //                 children: [
      //                   Text(
      //                     'User Name ',
      //                     style: TextStyle(
      //                         fontWeight: FontWeight.w400,
      //                         color: Colors.black87,
      //                         fontSize: 25),
      //                   ),
      //                 ],
      //               ),
      //               Row(
      //                 mainAxisAlignment: MainAxisAlignment.start,
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: [
      //                   Text(
      //                     'all your shortcuts ',
      //                     style: TextStyle(fontSize: 15, color: Colors.grey),
      //                   ),
      //                 ],
      //               )
      //             ],
      //           )
      //         ],
      //       ),
      //       SizedBox(
      //         height: 24.0,
      //       ),
      //       Row(
      //         children: [
      //           SizedBox(
      //             width: 13.0,
      //           ),
      //           Column(
      //             children: [
      //               Icon(
      //                 Icons.phone,
      //                 color: Colors.grey,
      //                 size: 18,
      //               ),
      //             ],
      //           ),
      //           SizedBox(
      //             width: 15.0,
      //           ),
      //           Column(
      //             children: [
      //               InkWell(
      //                 onTap: () {},
      //                 child: Text(
      //                   '(581)-307-6902',
      //                   style: TextStyle(color: Colors.grey, fontSize: 13),
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ],
      //       ),
      //       SizedBox(
      //         height: 16.0,
      //       ),
      //       Row(
      //         children: [
      //           SizedBox(
      //             width: 13.0,
      //           ),
      //           Column(
      //             children: [
      //               Icon(
      //                 Icons.email_outlined,
      //                 color: Colors.grey,
      //                 size: 18,
      //               ),
      //             ],
      //           ),
      //           SizedBox(
      //             width: 15.0,
      //           ),
      //           Column(
      //             children: [
      //               InkWell(
      //                 onTap: () {},
      //                 child: Text(
      //                   ' user.name@gmail.com',
      //                   style: TextStyle(color: Colors.grey, fontSize: 13),
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ],
      //       ),
      //       SizedBox(
      //         height: 24.0,
      //       ),
      //       Container(
      //         height: 1,
      //         color: Colors.grey[200],
      //       ),
      //       SizedBox(
      //         height: 24.0,
      //       ),
      //       Row(
      //         children: [
      //           SizedBox(
      //             width: 13.0,
      //           ),
      //           Column(
      //             children: [
      //               Icon(
      //                 Icons.favorite_border_rounded,
      //                 color: Colors.black38,
      //                 size: 25,
      //               ),
      //             ],
      //           ),
      //           SizedBox(
      //             width: 15.0,
      //           ),
      //           Column(
      //             children: [
      //               InkWell(
      //                 onTap: () {},
      //                 child: Text(
      //                   'Your Favorites',
      //                   style: TextStyle(color: Colors.black87, fontSize: 18),
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ],
      //       ),
      //       SizedBox(
      //         height: 24.0,
      //       ),
      //       Row(
      //         children: [
      //           SizedBox(
      //             width: 13.0,
      //           ),
      //           Column(
      //             children: [
      //               Icon(
      //                 Icons.gavel,
      //                 color: Colors.black38,
      //                 size: 25,
      //               ),
      //             ],
      //           ),
      //           SizedBox(
      //             width: 15.0,
      //           ),
      //           Column(
      //             children: [
      //               InkWell(
      //                 onTap: () {},
      //                 child: Text(
      //                   'Your Bids',
      //                   style: TextStyle(color: Colors.black87, fontSize: 18),
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ],
      //       ),
      //       SizedBox(
      //         height: 24.0,
      //       ),
      //       Row(
      //         children: [
      //           SizedBox(
      //             width: 13.0,
      //           ),
      //           Column(
      //             children: [
      //               Icon(
      //                 Icons.post_add,
      //                 color: Colors.black38,
      //                 size: 25,
      //               ),
      //             ],
      //           ),
      //           SizedBox(
      //             width: 15.0,
      //           ),
      //           Column(
      //             children: [
      //               InkWell(
      //                 onTap: () {},
      //                 child: Text(
      //                   'Your Posts',
      //                   style: TextStyle(color: Colors.black87, fontSize: 18),
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ],
      //       ),
      //       SizedBox(
      //         height: 24.0,
      //       ),
      //       Row(
      //         children: [
      //           SizedBox(
      //             width: 13.0,
      //           ),
      //           Column(
      //             // ignore: prefer_const_literals_to_create_immutables
      //             children: [
      //               Icon(
      //                 Icons.account_balance_wallet_outlined,
      //                 color: Colors.black38,
      //                 size: 25,
      //               ),
      //             ],
      //           ),
      //           SizedBox(
      //             width: 15.0,
      //           ),
      //           Column(
      //             children: [
      //               InkWell(
      //                 onTap: () {},
      //                 child: Text(
      //                   'Payment',
      //                   style: TextStyle(color: Colors.black87, fontSize: 18),
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ],
      //       ),
      //       SizedBox(
      //         height: 24.0,
      //       ),
      //       Row(
      //         children: [
      //           SizedBox(
      //             width: 13.0,
      //           ),
      //           Column(
      //             // ignore: prefer_const_literals_to_create_immutables
      //             children: [
      //               Icon(
      //                 Icons.person,
      //                 color: Colors.black38,
      //                 size: 25,
      //               ),
      //             ],
      //           ),
      //           SizedBox(
      //             width: 15.0,
      //           ),
      //           Column(
      //             children: [
      //               InkWell(
      //                 onTap: () {},
      //                 child: Text(
      //                   'profile',
      //                   style: TextStyle(color: Colors.black87, fontSize: 18),
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ],
      //       ),
      //       SizedBox(
      //         height: 24.0,
      //       ),
      //       Row(
      //         children: [
      //           SizedBox(
      //             width: 13.0,
      //           ),
      //           Column(
      //             // ignore: prefer_const_literals_to_create_immutables
      //             children: [
      //               Icon(
      //                 Icons.settings,
      //                 color: Colors.black38,
      //                 size: 25,
      //               ),
      //             ],
      //           ),
      //           SizedBox(
      //             width: 15.0,
      //           ),
      //           Column(
      //             children: [
      //               InkWell(
      //                 onTap: () {},
      //                 child: Text(
      //                   'Settings',
      //                   style: TextStyle(color: Colors.black87, fontSize: 18),
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ],
      //       ),
      //       SizedBox(
      //         height: 24.0,
      //       ),
      //       Container(
      //         height: 1,
      //         color: Colors.grey[200],
      //       ),
      //       SizedBox(
      //         height: 24.0,
      //       ),
      //       Row(
      //         children: [
      //           SizedBox(
      //             width: 13.0,
      //           ),
      //           Column(
      //             // ignore: prefer_const_literals_to_create_immutables
      //             children: [
      //               Icon(
      //                 Icons.power_settings_new,
      //                 color: Colors.red,
      //                 size: 25,
      //               ),
      //             ],
      //           ),
      //           SizedBox(
      //             width: 15.0,
      //           ),
      //           Column(
      //             children: [
      //               InkWell(
      //                 onTap: () {},
      //                 child: Text(
      //                   'Log out',
      //                   style: TextStyle(color: Colors.red, fontSize: 18),
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ],
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
