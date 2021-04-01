import 'package:flutter/material.dart';

Card moviePoster(
    {@required List<dynamic> poster, @required BuildContext context}) {
  return Card(
    child: ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      child: Container(
        width: MediaQuery.of(context).size.width / 4,
        height: 160,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(poster[0]),
            fit: BoxFit.fill,
          ),
        ),
      ),
    ),
  );
}
