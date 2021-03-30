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
          return movieCard(_movies, context, index);
          // return Card(
          //   elevation: 4.5,
          //   color: Colors.white,
          //   child: ListTile(
          //     leading: CircleAvatar(
          //       radius: 30,
          //       child: Container(
          //         height: 200,
          //         width: 200,
          //         decoration: BoxDecoration(
          //           image: DecorationImage(
          //             fit: BoxFit.cover,
          //             image: NetworkImage(
          //               getImage(index, context),
          //             ),
          //           ),
          //           borderRadius: BorderRadius.circular(45),
          //         ),
          //       ),
          //     ),
          //     title: Text(_movies[index]["Title"]),
          //     subtitle: Text(_movies[index]["Released"]),
          //     trailing: Text("$index"),
          //     onTap: () => Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => MovieListViewDetails(
          //           movieName: _movies[index]["Title"],
          //           movie: _movies,
          //           index: index,
          //         ),
          //       ),
          //     ),
          //   ),
          // );
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
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 6.5,
        child: Card(
          color: Colors.black45,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 54.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_movies[index][movieData.title]),
                    Text("Rating: ${_movies[index][movieData.imdbrating]}/10")
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("Released: ${_movies[index][movieData.released]}"),
                    Text(_movies[index][movieData.runtime]),
                    Text(_movies[index][movieData.rated]),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
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
