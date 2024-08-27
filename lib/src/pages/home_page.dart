import 'package:flutter/material.dart';
import 'package:movies/src/providers/movies_provider.dart';
import 'package:movies/src/search/search_delegate.dart';
import 'package:movies/src/widgets/card_swipe_widget.dart';
import 'package:movies/src/widgets/movie_horizontal.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final MoviesProvider moviesProvider = MoviesProvider();

  @override
  Widget build(BuildContext context) {

    moviesProvider.getPopular();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies on showcase'),
        centerTitle: true,
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: DataSearch(),
              );
            },
            icon: const Icon(Icons.search, color: Colors.white)
          )
        ],
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _swipeCards(),
          _footer(context),
        ]
      ),
    );
  }

  Widget _swipeCards() {
    return FutureBuilder(
      future: moviesProvider.getNowPlaying(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        
        if (snapshot.hasData) {
          return CardSwiper(movies: snapshot.data);
        } else {
          return const SizedBox(
            height: 400.0,
            child: Center(
              child: CircularProgressIndicator()
            )
          );
        }
      }
    );
  }

  Widget _footer(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text('Popular', style: Theme.of(context).textTheme.titleMedium)
          ),
          
          const SizedBox(height: 15.0),

          StreamBuilder(
            stream: moviesProvider.popularStream,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              
              if (snapshot.hasData) {
                return MovieHorizontal(movies: snapshot.data, nextPage: moviesProvider.getPopular,);
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }
          ),

        ],
      ),
    );
  }
}