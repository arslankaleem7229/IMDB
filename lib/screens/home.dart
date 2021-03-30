import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:imdb/models/movie.dart';

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

  List movies = [];

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/movies.json');
    final data = await json.decode(response);
    setState(() {
      movies = data["movies"];
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
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4.5,
            color: Colors.white,
            child: ListTile(
              leading: CircleAvatar(
                child: Container(
                  child: Text("M"),
                  decoration: BoxDecoration(
                    // color: Colors.blue,
                    borderRadius: BorderRadius.circular(45),
                  ),
                ),
              ),
              title: Text(movies[index]["Title"]),
              subtitle: Text(movies[index]["Released"]),
              trailing: Text("$index"),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MovieListViewDetails(
                    movieName: movies[index]["Title"],
                    movie: movies[index],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class MovieListViewDetails extends StatelessWidget {
  final String movieName;
  final Movie movie;
  MovieListViewDetails({this.movieName, this.movie});
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
            child: Text("GO BACK"),
          ),
        ),
      ),
    );
  }
}
