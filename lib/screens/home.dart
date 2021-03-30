import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:imdb/models/movie.dart';

Movie movieData = Movie();

class MovieListView extends StatefulWidget {
  @override
  _MovieListViewState createState() => _MovieListViewState();
}

class _MovieListViewState extends State<MovieListView> {
  @override
  void initState() {
    super.initState();
    readJson();
  }

  List _movies = [];

  Future<void> readJson() async {
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
        title: Text("Movies"),
        backgroundColor: Colors.blueGrey.shade900,
      ),
      backgroundColor: Colors.blueGrey.shade400,
      body: ListView.builder(
        itemCount: _movies.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4.5,
            color: Colors.white,
            child: ListTile(
              leading: CircleAvatar(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: getImage(index),
                    ),
                    borderRadius: BorderRadius.circular(45),
                  ),
                ),
              ),
              title: Text(_movies[index]["Title"]),
              subtitle: Text(_movies[index]["Released"]),
              trailing: Text("$index"),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MovieListViewDetails(
                    movieName: _movies[index]["Title"],
                    movie: _movies,
                    index: index,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  getImage(int index) {
    NetworkImage posterData;
    posterData = NetworkImage(_movies[index][movieData.poster]);
    if (posterData != null) {
      return posterData;
    } else {
      posterData = NetworkImage(_movies[index]["Images"][0]);
      return posterData;
    }
  }
}

class MovieListViewDetails extends StatelessWidget {
  final String movieName;
  final List<dynamic> movie;
  final int index;
  MovieListViewDetails({this.movieName, this.movie, this.index});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movies"),
        backgroundColor: Colors.blueGrey.shade900,
      ),
      body: Center(
        child: Container(
          child: ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: Text(movie[index][movieData.title]),
          ),
        ),
      ),
    );
  }
}
