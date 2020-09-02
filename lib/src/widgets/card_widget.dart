import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas/src/models/pelicula_modelo.dart';

class CardSwiper extends StatelessWidget {

  final List<Pelicula> peliculas;

  CardSwiper({ @required this.peliculas });

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemWidth: _screenSize.width * 0.44,
        itemHeight: _screenSize.height * 0.44,
        itemBuilder: (BuildContext context, int index) {
          
          final tarjeta = ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              image: NetworkImage( peliculas[index].getPosterImg() ),
              placeholder: AssetImage('assets/img/loading.gif'),
              fit: BoxFit.cover
            )
          );

          return GestureDetector(
            child: tarjeta,
            onTap: () {

              Navigator.pushNamed(context, 'detalle', arguments: peliculas[index]);

            },
          );

        },
        itemCount: peliculas.length,
        
        // pagination: SwiperPagination(),
        // control: SwiperControl()
      )
    );

  }
}