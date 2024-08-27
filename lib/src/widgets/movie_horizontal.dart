import 'package:flutter/material.dart';
import 'package:movies/src/models/movie_model.dart';

class MovieHorizontal extends StatelessWidget {
  MovieHorizontal({super.key, required this.movies, required this.nextPage});

  final List<Movie> movies;
  final Function nextPage;

  final _pageController = PageController(
    initialPage: 1,
    viewportFraction: 0.3,
  );

  @override
  Widget build(BuildContext context) {

    final screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      if (_pageController.position.pixels >= _pageController.position.maxScrollExtent - 200) {
        nextPage();
      }
    });

    return SizedBox(
      height: screenSize.height * 0.2,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemCount: movies.length,
        itemBuilder: (contex, i) => _card(context, movies[i]),
      ),
    );
  }

  Widget _card(BuildContext context, Movie movie) {

    movie.uniqueId = '${movie.id}-poster';

    final card = Container(
      padding: const EdgeInsets.only(left: 5.0),
      child: Column(
        children: <Widget>[
          Hero(
            tag: movie.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: FadeInImage(
                placeholder: const AssetImage('assets/img/no_image.jpg'),
                image: NetworkImage(movie.getPosterImg()),
                height: 125.0,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 5.0),
          Text(
            movie.title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.labelSmall,
          )
        ],
      )
    );

    return GestureDetector(
      child: card,
      onTap: () {
        Navigator.pushNamed(context, 'detail', arguments: movie);
      },
    );
  }

}