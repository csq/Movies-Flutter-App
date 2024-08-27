import 'package:flutter/material.dart';
import 'package:movies/src/models/movie_model.dart';
import 'package:movies/src/providers/movies_provider.dart';

class DataSearch extends SearchDelegate {
  final moviesProvider = MoviesProvider();

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => {
        close(context, null),
      },
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    if (query.isEmpty) {
      return Container();
    }

    return FutureBuilder(
      future: moviesProvider.searchMovie(query),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
        if (snapshot.hasData) {
          final movies = snapshot.data;

          return ListView(
              children: movies!.map((movie) {
            return ListTile(
              leading: FadeInImage(
                image: NetworkImage(movie.getPosterImg()),
                placeholder: const AssetImage('assets/img/no_image.jpg'),
                width: 50.0,
                fit: BoxFit.contain,
              ),
              title: Text('${movie.title} (${movie.releaseDate.split('-').first})'),
              subtitle: Text(movie.originalTitle),
              onTap: () {
                close(context, null);
                movie.uniqueId = '';
                Navigator.pushNamed(context, 'detail', arguments: movie);
              },
            );
          }).toList());
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
