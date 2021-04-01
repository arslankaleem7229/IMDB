import 'package:flutter/cupertino.dart';
import 'package:imdb/screens/home.dart';
import 'package:imdb/screens/moviefield.dart';

Padding movieDetailCast({@required List<dynamic> movie, @required int index}) {
  return Padding(
    padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 10.0),
    child: Column(
      children: [
        movieField(field: "Cast", value: movie[index][movieData.actors]),
        movieField(field: "Directors", value: movie[index][movieData.director]),
        movieField(field: "Awards", value: movie[index][movieData.awards]),
      ],
    ),
  );
}
