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
          builder: (context) => MovieListViewDetails(
            movieName: _movies[index]["Title"],
            movie: _movies,
            index: index,
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
      body: ListView(
        children: [
          MovieDetailThumbnail(movie[index][movieData.poster]),
          MovieDetailHeaderWithPoster(movie, index),
          MovieDetailCast(movie, index),
          HorizontalLine(),
          MovieExtraPosters(movie[index]["Images"]),
        ],
      ),
    );
  }
}

class MovieDetailThumbnail extends StatelessWidget {
  final String thumbnail;
  MovieDetailThumbnail(this.thumbnail);
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.99,
              height: MediaQuery.of(context).size.height * 0.30,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(thumbnail),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Icon(
              Icons.play_circle_outline,
              size: 100.0,
              color: Colors.white,
            ),
          ],
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0x00f5f5f5),
                Color(0xfff5f5f5),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          height: 80.0,
        )
      ],
    );
  }
}

class MovieDetailHeaderWithPoster extends StatelessWidget {
  final List<dynamic> movie;
  final int index;
  MovieDetailHeaderWithPoster(this.movie, this.index);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          MoviePoster(movie[index]["Images"]),
          SizedBox(width: 16.0),
          Expanded(child: MovieDetailHeader(movie, index)),
        ],
      ),
    );
  }
}

class MoviePoster extends StatelessWidget {
  final List<dynamic> poster;
  MoviePoster(this.poster);

  @override
  Widget build(BuildContext context) {
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
}

class MovieDetailHeader extends StatelessWidget {
  final int index;
  final List<dynamic> movie;
  MovieDetailHeader(this.movie, this.index);
  @override
  Widget build(BuildContext context) {
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
          style:
              TextStyle(fontWeight: FontWeight.w600, color: Colors.blueAccent),
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
}

class MovieDetailCast extends StatelessWidget {
  final List<dynamic> movie;
  final int index;

  const MovieDetailCast(this.movie, this.index);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 10.0),
      child: Column(
        children: [
          MovieField("Cast", movie[index][movieData.actors]),
          MovieField("Directors", movie[index][movieData.director]),
          MovieField("Awards", movie[index][movieData.awards]),
        ],
      ),
    );
  }
}

class MovieField extends StatelessWidget {
  final String field;
  final String value;
  MovieField(this.field, this.value);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$field : ",
          style: TextStyle(
            color: Colors.black38,
            fontSize: 12.0,
            fontWeight: FontWeight.w300,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: Colors.black,
              fontSize: 12.0,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ],
    );
  }
}

class HorizontalLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
      height: 0.5,
      color: Colors.grey,
    );
  }
}

class MovieExtraPosters extends StatelessWidget {
  final List<dynamic> posters;
  MovieExtraPosters(this.posters);
  @override
  Widget build(BuildContext context) {
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
}
