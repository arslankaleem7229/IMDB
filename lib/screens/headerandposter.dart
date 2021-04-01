import 'package:flutter/material.dart';
import 'package:imdb/screens/moviedetailheader.dart';
import 'package:imdb/screens/movieposter.dart';

Padding movieDetailHeaderWithPoster(
    {@required List<dynamic> movie,
    @required int index,
    @required BuildContext context}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Row(
      children: [
        moviePoster(poster: movie[index]["Images"], context: context),
        SizedBox(width: 16.0),
        Expanded(child: movieDetailHeader(movie: movie, index: index)),
      ],
    ),
  );
}
