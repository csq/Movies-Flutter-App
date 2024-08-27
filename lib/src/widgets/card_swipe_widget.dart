import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:movies/src/models/movie_model.dart';

class CardSwiper extends StatelessWidget {
  
  final List<Movie> movies;

  const CardSwiper({super.key,  required this.movies});

  @override
  Widget build(BuildContext context) {

    final screenSize = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.only(top: 10.0),
      child: Swiper(
        layout: SwiperLayout.STACK,
        
        itemWidth: screenSize.width * 0.7,
        itemHeight: screenSize.height * 0.5,
        itemBuilder: (BuildContext context, int index){
          
          movies[index].uniqueId = '${movies[index].id}-card';
          
          return Hero(
            tag: movies[index].uniqueId,
            child: (
              GestureDetector(
                onTap: () => {
                  Navigator.pushNamed(context, 'detail', arguments: movies[index]),
                },
                child: FadeInImage(
                  image: NetworkImage(movies[index].getPosterImg()),
                  placeholder: const AssetImage('assets/img/no_image.jpg'),
                ),
              )
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}