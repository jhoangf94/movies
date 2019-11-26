import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Pelicula> peliculas;
  final void Function() getNextsPopularsMovies;

  final PageController _pageController =
      new PageController(viewportFraction: 0.3);

  MovieHorizontal({@required this.peliculas, this.getNextsPopularsMovies});

  @override
  Widget build(BuildContext context) {
    Size _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 250) {
        getNextsPopularsMovies();
      }
    });

    return Container(
      height: _screenSize.height * 0.2,
      width: _screenSize.width,
      child: PageView.builder(
        controller: _pageController,
        pageSnapping: false,
        itemCount: peliculas.length,
        itemBuilder: (context, i) => _card(peliculas[i], context, _screenSize),
      ),
    );
  }

  Widget _card(Pelicula pelicula, BuildContext context, Size screenSize) {
    pelicula.uniqueID = '${pelicula.id}-movie-horizontal';
    final card = Container(
      margin: EdgeInsets.only(right: 25.0),
     // color: Colors.red,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Hero(
            tag: pelicula.uniqueID,
                      child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: FadeInImage(
                image: NetworkImage(pelicula.getImageURL()),
                placeholder: AssetImage('assets/img/no-image.png'),
                height: screenSize.height * 0.17,
                width: screenSize.width,
                fit: BoxFit.cover,
              ),
            ),
          ),
          _getText(pelicula, context)
        ],
      ),
    );

    return GestureDetector(
      child: card,
      onTap: () {
        Navigator.of(context).pushNamed('detail', arguments: pelicula);
      },
    );
  }

  Container _getText(Pelicula pelicula, BuildContext context) {
    return Container(
      child: Text(
        pelicula.title,
        maxLines: 1,
        style: Theme.of(context).textTheme.caption,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
