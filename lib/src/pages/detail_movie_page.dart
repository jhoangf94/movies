import 'package:flutter/material.dart';
import 'package:peliculas/src/models/actor_model.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/providers/actors_provider.dart';

class DetailMovie extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        _sliverAppbar(context, pelicula),
        SliverList(
          delegate: SliverChildListDelegate([
            _sliverHead(context, pelicula),
            _sliverBody(pelicula),
            SizedBox(height: 45.0),
            _listActors(pelicula),
          ]),
        )
        // _sliverBody()
      ],
    ));
  }

  Widget _sliverAppbar(BuildContext context, Pelicula pelicula) {
    final backgorundAppbar = Container(
      child: FadeInImage(
        image: NetworkImage(pelicula.getBackdropPathImageURL()),
        placeholder: AssetImage('assets/img/loading.gif'),
        fit: BoxFit.cover,
        height: 200.0,
        fadeInDuration: Duration(milliseconds: 300),
      ),
    );

    return SliverAppBar(
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 2.0,
      floating: false,
      pinned: true,
      expandedHeight: 200.0,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.only(bottom: 0.0),
        background: backgorundAppbar,
        title: Container(
          height: 30.0,
          width: MediaQuery.of(context).size.width,
          color: Colors.black45,
          child: Center(
            child: Text(
              pelicula.title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Widget _sliverHead(BuildContext context, Pelicula pelicula) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
      child: Row(
        children: <Widget>[
          Hero(
            tag: pelicula.uniqueID,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image(
                height: 150.0,
                fit: BoxFit.cover,
                image: NetworkImage(pelicula.getImageURL()),
              ),
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  pelicula.title,
                  style: Theme.of(context).textTheme.headline,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  pelicula.originalTitle,
                  style: Theme.of(context).textTheme.subhead,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: <Widget>[
                    Icon(Icons.star_border),
                    Text(
                      pelicula.voteAverage.toString(),
                      style: Theme.of(context).textTheme.subhead,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _sliverBody(Pelicula pelicula) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
      child: Text(
        pelicula.overview,
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _listActors(Pelicula pelicula) {
    final actorsProvider = ActorsProvider();

    return FutureBuilder(
      future: actorsProvider.getActors(pelicula.id.toString()),
      builder: (context, AsyncSnapshot<List<Actor>> snapshot) {
        final actors = snapshot.data;
        return (!snapshot.hasData)
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                height: 150.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, i) {
                    return _cardActor(actors[i]);
                  },
                ),
              );
      },
    );
  }

  Widget _cardActor(Actor actor) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              image: NetworkImage(actor.getImageURL()),
              placeholder: AssetImage('assets/img/no-image.png'),
              fit: BoxFit.cover,
              width: 100,
            ),
          ),
          Positioned(
              bottom: 0.0,
              left: 1.0,
              right: 1.0,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0)),
                child: Container(
                  height: 20.0,
                  color: Colors.black38,
                  child: Center(
                    child: Text(
                      actor.name,
                      style: TextStyle(
                        fontSize: 10.0,
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
