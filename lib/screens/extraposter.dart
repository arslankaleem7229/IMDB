import 'package:flutter/material.dart';

movieExtraPosters({@required List<dynamic> posters}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "More Movie Posters ...",
        style: TextStyle(
          fontSize: 14.0,
          color: Colors.black26,
        ),
      ),
      Container(
        height: 170,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          separatorBuilder: (context, index) => SizedBox(width: 10.0),
          itemCount: posters.length,
          itemBuilder: (context, index) {
            return ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              child: Container(
                width: MediaQuery.of(context).size.width / 4,
                // height: 160,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(posters[index]),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    ],
  );
}
