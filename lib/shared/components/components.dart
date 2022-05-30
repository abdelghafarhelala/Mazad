// ignore_for_file: prefer_const_constructors

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:graduation_app/shared/style/color.dart';

//abdo
Widget defaultButton({
  double width = double.infinity,
  // Color color = Colors.blue,
  required Function onpress,
  required String text,
  double radius = 0.0,
  bool isUpper = true,
  // asasddassda
}) =>
    Container(
      width: width,
      child: MaterialButton(
        onPressed: () {
          onpress();
        },
        child: Text(
          isUpper ? text.toUpperCase() : text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: defaultColor,
      ),
    );

Widget defaulttextfield({
  required String lable,
  required IconData prefix,
  required Function? validate,
  required context,
  IconData? suffix,
  int? maxLines = 1,
  Function? suffixPressed,
  bool isSecure = false,
  required TextInputType type,
  var controller,
  Function? ontap,
  // Function? onChange,
}) =>
    TextFormField(
      maxLines: maxLines,
      style: Theme.of(context).textTheme.button,
      decoration: InputDecoration(
        labelText: lable,
        border: const UnderlineInputBorder(),
        prefixIcon: Icon(prefix),
        suffixIcon: IconButton(
            icon: Icon(suffix),
            onPressed: () {
              suffixPressed!();
            }),
      ),
      keyboardType: type,
      obscureText: isSecure,
      validator: (String? s) {
        return validate!(s);
      },
      controller: controller,
      onTap: () {
        ontap!();
      },
      // onChanged: (String s){
      //     onChange!(s);
      // },
    );

Widget lineSpreate() => Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Container(
        width: double.infinity,
        height: 1,
        color: Colors.grey,
      ),
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );

void navigateAndFinsh(context, widget) => Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (context) => widget), (route) {
      return false;
    });

void showToast({@required String? text, @required ToastStates? state}) =>
    Fluttertoast.showToast(
        msg: text!,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: toastColor(state!),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastStates { success, error, Warrnaing }

Color? color;
Color? toastColor(ToastStates state) {
  switch (state) {
    case ToastStates.success:
      color = Colors.green;
      break;
    case ToastStates.error:
      color = Colors.red;
      break;
    case ToastStates.Warrnaing:
      color = Colors.amber;
      break;
  }
  return color;
}

Widget buildProductItem({
  Map? mymap,
  context,
  required Widget navigate,
  required String image,
  required String name,
  String? startDate,
  String? endDate,
  String? startPrice,
}) =>
    InkWell(
      onTap: () {
        navigateTo(context, navigate);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              // color: Colors.red,
              height: 200,
              width: 200,
              child: Image(
                image: NetworkImage(image),
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
                    name,
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
                      if (startDate != null)
                        Text(
                          // '${model.price.round()}',
                          'StartDate: ' + startDate,
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.red,
                          ),
                        ),
                      Spacer(),
                      if (endDate != null)
                        Text(
                          // '${model.price.round()}',
                          'EndDate: ' + endDate,
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.red,
                          ),
                        ),
                    ],
                  ),
                  if (startPrice != null)
                    Row(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Text(
                          // '${model.price.round()}',
                          'StartPrice: ' + startPrice,
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

                          icon: mymap != ''
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
