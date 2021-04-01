import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:imdb/models/movie.dart';
import 'package:imdb/screens/divider.dart';
import 'package:imdb/screens/thumbnail.dart';

import 'extraposter.dart';
import 'headerandposter.dart';
import 'moviedetailcast.dart';

Scaffold movieListViewDetails(
    {@required String movieName,
    @required List<dynamic> movie,
    @required int index,
    @required BuildContext context}) {
  Movie movieData = Movie();
  return Scaffold(
    appBar: AppBar(
      title: SvgPicture.asset(
        "assets/images/imdb.svg",
        width: 90.0,
        alignment: Alignment.centerLeft,
      ),
      backgroundColor: Colors.blueGrey.shade900,
    ),
    body: ListView(
      children: [
        movieDetailThumbnail(
            thumbnail: movie[index][movieData.poster], context: context),
        movieDetailHeaderWithPoster(
            movie: movie, index: index, context: context),
        movieDetailCast(movie: movie, index: index),
        horizontalLine(),
        movieExtraPosters(posters: movie[index]["Images"]),
      ],
    ),
  );
}
