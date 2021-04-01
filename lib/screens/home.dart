import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:imdb/models/movie.dart';
import 'package:imdb/screens/movieListVeiwDetail.dart';

Movie movieData = Movie();

class MovieListView extends StatefulWidget {
  @override
  _MovieListViewState createState() => _MovieListViewState();
}

class _MovieListViewState extends State<MovieListView> {
  @override
  void initState() {
    super.initState();
    _readJson();
  }

  List _movies = [];
  Future<void> _readJson() async {
    final String response = await rootBundle.loadString('assets/movies.json');
    final data = await json.decode(response);
    setState(() {
      _movies = data["movies"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu_rounded, size: 40.0),
        title: SvgPicture.asset(
          "assets/images/imdb.svg",
          width: 90.0,
          alignment: Alignment.centerLeft,
        ),
        actions: [
          Icon(Icons.search, size: 40.0),
          Icon(Icons.more_vert_outlined, size: 40.0),
        ],
        leadingWidth: 30,
        backgroundColor: Colors.blueGrey.shade900,
      ),
      backgroundColor: Colors.blueGrey.shade900,
      body: ListView.builder(
        itemCount: _movies.length,
        itemBuilder: (context, index) {
          return Stack(
            children: [
              Positioned(
                child: movieCard(_movies, context, index),
              ),
              Positioned(
                top: 10.0,
                child: movieImage(_movies[index][movieData.poster]),
              ),
            ],
          );
        },
      ),
    );
  }

  String getImage(int index, BuildContext context) {
    String posterData = _movies[index][movieData.poster];
    Image.network(posterData, errorBuilder: (context, url, error) {
      posterData = _movies[index]["Images"][0];
      return Image.network(posterData, errorBuilder: (context, url, error) {
        posterData =
            "https://cdn.iconscout.com/icon/free/png-512/no-image-1771002-1505134.png";
        return Image.network(posterData, errorBuilder: (context, url, error) {
          return Icon(
            Icons.error,
            color: Colors.red,
          );
        });
      });
    });

    return posterData;
  }

  Widget movieCard(List<dynamic> movie, BuildContext context, int index) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(left: 60.0),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 6.5,
        child: Card(
          color: Colors.black45,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 54.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          _movies[index][movieData.title],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Text(
                        "Rating: ${_movies[index][movieData.imdbrating]}/10",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Released: ${_movies[index][movieData.released]}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        _movies[index][movieData.runtime],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        _movies[index][movieData.rated],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => movieListViewDetails(
            movieName: _movies[index]["Title"],
            movie: _movies,
            index: index,
            context: context,
          ),
        ),
      ),
    );
  }

  Widget movieImage(String imageUrl) {
    return Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
            image: NetworkImage(
              imageUrl ??
                  "https://cdn.iconscout.com/icon/free/png-512/no-image-1771002-1505134.png",
            ),
            fit: BoxFit.cover),
      ),
    );
  }
}
