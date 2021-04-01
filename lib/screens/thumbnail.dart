import 'package:flutter/material.dart';

movieDetailThumbnail(
    {@required String thumbnail, @required BuildContext context}) {
  return Stack(
    alignment: Alignment.bottomCenter,
    children: [
      Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.99,
            height: MediaQuery.of(context).size.height * 0.30,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(thumbnail),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Icon(
            Icons.play_circle_outline,
            size: 100.0,
            color: Colors.white,
          ),
        ],
      ),
      Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0x00f5f5f5),
              Color(0xfff5f5f5),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        height: 80.0,
      )
    ],
  );
}
