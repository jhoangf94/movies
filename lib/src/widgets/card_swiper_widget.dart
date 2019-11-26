import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class CardSwiper extends StatelessWidget {
  final List<Pelicula> peliculas;

  CardSwiper({@required this.peliculas});

  @override
  Widget build(BuildContext context) {
    Size _screenSize = MediaQuery.of(context).size;
    double swipeWidth = _screenSize.width * 0.7;
    double height = _screenSize.height * 0.6;

    return Container(
      padding: EdgeInsets.only(top: 20.0),
      width: _screenSize.width,
      height: height,
      child: Swiper(
          itemCount: peliculas.length,
          itemWidth: swipeWidth,
          layout: SwiperLayout.STACK,
          itemBuilder: (BuildContext context, int index) {
            Pelicula pelicula = peliculas[index];
            pelicula.uniqueID = '${pelicula.id}-card-swiper';
            return Hero(
              tag: pelicula.uniqueID,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed('detail', arguments: pelicula);
                },
                              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: FadeInImage(
                    placeholder: AssetImage('assets/img/no-image.png'),
                    image: NetworkImage(pelicula.getImageURL()),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          }),
    );
  }
}
