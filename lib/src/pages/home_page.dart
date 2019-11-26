import 'package:flutter/material.dart';
import 'package:peliculas/src/delegates/search_delegate.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';
import 'package:peliculas/src/widgets/card_swiper_widget.dart';
import 'package:peliculas/src/widgets/movie_horizontal_widget.dart';

class HomePage extends StatelessWidget {
  final PeliculasProvider _peliculasProvider = new PeliculasProvider();

  @override
  Widget build(BuildContext context) {

    _peliculasProvider.getPopulars();

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Peliculas',
            style: TextStyle(fontSize: 25.0, color: Colors.white),
          ),
          backgroundColor: Theme.of(context).accentColor,
          elevation: 0.0,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () async {
                
                var result = await showSearch(
                  context: context,
                  delegate: SearchData()
                );
                result.uniqueID = '${result.id}-home';
                Navigator.of(context).pushNamed('detail', arguments: result);
              },
            )
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _swiper(context),
            Container(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                'Populares',
                style: Theme.of(context).textTheme.title,
              ),
            ),
            _movieHorizontal()
          ],
        ));
  }

  Widget _swiper(BuildContext context) {
    Size _screenSize = MediaQuery.of(context).size;

    return FutureBuilder(
      future: _peliculasProvider.getInCinemas(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(
            peliculas: snapshot.data,
          );
        } else {
          return Container(
            width: _screenSize.width,
            height: _screenSize.height * 0.5,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  Widget _movieHorizontal() {
    return Container(
      child: StreamBuilder(
        stream: _peliculasProvider.popularesStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return MovieHorizontal(peliculas: snapshot.data, getNextsPopularsMovies: () {
              _peliculasProvider.getPopulars();
            },);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
