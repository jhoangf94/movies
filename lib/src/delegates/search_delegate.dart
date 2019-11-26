import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';

class SearchData extends SearchDelegate {
 
  Pelicula movieSelected;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    query.toLowerCase();
    return FutureBuilder(
      future: PeliculasProvider().searchMovies(query),
      builder: (context, AsyncSnapshot<List<Pelicula>> snapshot) {
        if (snapshot.hasData) {
          return _buildSuggestions(snapshot.data);
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildSuggestions(List<Pelicula> peliculas) {
    return ListView.builder(
      itemCount: peliculas.length,
      itemBuilder: (context, i) {
        final movie = peliculas[i];
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
          child: GestureDetector(
            onTap: (){
              movieSelected = movie;
              close(context, movie);
            },
                      child: Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(4.0),
                  child: FadeInImage(
                    image: NetworkImage(movie.getImageURL()),
                    placeholder: AssetImage('assets/img/no-image.png'),
                    fit: BoxFit.cover,
                    width: 40.0,
                    height: 50.0,
                  ),
                ),
                SizedBox(width: 10.0),
                Text(
                  movie.title,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ),
        );
      },
    );
  }

  // @override
  // Widget buildSuggestions(BuildContext context) {
  //   query = query.toLowerCase();
  //   final List<String> sugestionsFilter = suggestions
  //       .where((peli) => peli.toLowerCase().startsWith(query))
  //       .toList();

  //   return query.isEmpty
  //       ? Container()
  //       : Column(
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           children: sugestionsFilter.map((p) {
  //             return Container(
  //               padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
  //               child: Row(
  //                 children: <Widget>[
  //                   Icon(Icons.movie_filter),
  //                   SizedBox(width: 10.0),
  //                   Text(p)
  //                 ],
  //               ),
  //             );
  //           }).toList());
  // }
}
