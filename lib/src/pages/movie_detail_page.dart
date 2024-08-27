import 'package:flutter/material.dart';
import 'package:movies/src/models/actor_model.dart';
import 'package:movies/src/models/movie_model.dart';
import 'package:movies/src/providers/movies_provider.dart';

class MovieDetailPage extends StatelessWidget {
  const MovieDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _createAppbar(movie),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const SizedBox(height: 20.0),
                _posterTitle(context, movie),
                _description(movie),
                _createCasting(movie),
              ]
            )
          )
        ],
      ),
    );
  }

  Widget _createAppbar(Movie movie) {

    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.only(bottom: 5.0),
        title: Text(
          movie.title,
          style: const TextStyle(color: Colors.white, fontSize: 15.0),
        ),
        background: FadeInImage(
          image: (movie.getBackgroundImg() == 'no_available.jpg')
              ? const AssetImage('assets/img/no_available.jpg') as ImageProvider
              : NetworkImage(movie.getBackgroundImg()),
          placeholder: const AssetImage('assets/img/loading.gif'),
          fadeInDuration: const Duration(milliseconds: 150),
          fit: BoxFit.cover,
        ),
      ),
    );

  }

  Widget _posterTitle(BuildContext context, Movie movie) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
          Hero(
            tag: movie.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: Image(
                image: (movie.getPosterImg() == 'no_available.jpg')
                    ? const AssetImage('assets/img/no_available.jpg') as ImageProvider 
                    : NetworkImage(movie.getPosterImg()),
                height: 150.0,
                fit: BoxFit.cover,
              )
            ),
          ),
          const SizedBox(width: 20.0),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('${movie.title} (${movie.releaseDate.split('-').first})', style: Theme.of(context).textTheme.titleMedium, overflow: TextOverflow.ellipsis),
                Text(movie.originalTitle, style: Theme.of(context).textTheme.titleSmall, overflow: TextOverflow.ellipsis),
                Row(
                  children: <Widget>[
                    const Icon(Icons.star_rate_outlined),
                    Text(movie.voteAverage.toString(), style: Theme.of(context).textTheme.titleSmall)
                  ],
                )
              ],
            )
          )
        ]
      ),
    );
  }

  Widget _description(Movie movie) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 8.0, top: 8.0),
            child: Row(
              children: [
                Text(
                  'Synopsis',
                  style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.black)
                ),
              ],
            ),
          ),
          Column(
            children: [
              Text(
                movie.overview,
                textAlign: TextAlign.justify,
                style: const TextStyle(fontSize: 15.0),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _createCasting(Movie movie) {
    final moviesProvider = MoviesProvider();

    return FutureBuilder<List<Actor>>(
      future: moviesProvider.getCast(movie.id.toString()),
      builder: (context, AsyncSnapshot<List<Actor>?> snapshot) {
        if (snapshot.hasData) {
          final cast = snapshot.data!;
          return _createActorsPageView(cast);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _createActorsPageView(List<Actor> actors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(left: 10.0),
          child: const Text(
            'Cast',
            style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 200.0,
          child: PageView.builder(
            pageSnapping: false,
            controller: PageController(
              viewportFraction: 0.3,
              initialPage: 1,
            ),
            itemCount: actors.length,
            itemBuilder: (context , i) => _actorCard(actors[i]),
          ),
        ),
      ],
    );
  }

  Widget _actorCard(Actor actor) {
    return Container(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[
          Text(actor.name, style: const TextStyle(fontSize: 12.0,
            fontWeight: FontWeight.bold, color: Colors.black),
            overflow: TextOverflow.ellipsis
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: FadeInImage(
              placeholder: const AssetImage('assets/img/no_image.jpg'),
              image: (actor.getPicture() == 'no_avatar.gif')
                  ? const AssetImage('assets/img/no_avatar.gif') as ImageProvider
                  : NetworkImage(actor.getPicture()),
              height: 150.0,
              fit: BoxFit.cover,
            ),
          ),
          Visibility(
            visible: actor.character.isNotEmpty,
            child: Text(
              'As ${actor.character}', style: const TextStyle(fontSize: 12.0),
              overflow: TextOverflow.ellipsis
            ),
          ),
        ],
      ),
    );
  }

}
