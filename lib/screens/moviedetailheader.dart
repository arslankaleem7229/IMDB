import 'package:flutter/material.dart';
import 'package:imdb/screens/home.dart';

movieDetailHeader({@required int index, @required List<dynamic> movie}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "${movie[index][movieData.title]}",
        style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.blueAccent,
            fontSize: 32),
      ),
      Text(
        "${movie[index][movieData.year]} . ${movie[index][movieData.genre]}",
        style: TextStyle(fontWeight: FontWeight.w600, color: Colors.blueAccent),
      ),

      // Flexible(
      //   child: Text(movie[index][movieData.plot]),
      // ),
      Text.rich(
        TextSpan(
          style: TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 12.0,
            color: Colors.black,
          ),
          children: [
            TextSpan(
              text: movie[index][movieData.plot],
            ),
          ],
        ),
      ),
    ],
  );
}
