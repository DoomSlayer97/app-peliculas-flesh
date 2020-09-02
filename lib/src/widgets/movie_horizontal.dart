import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_modelo.dart';

class MovieHorizontal extends StatelessWidget {
  
  final List<Pelicula> peliculas;
  final Function siguientePagina;

  final _pageController = PageController(
    initialPage: 1,
    viewportFraction: 0.3
  );

  MovieHorizontal({ @required this.peliculas, @required this.siguientePagina });

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      
      if( _pageController.position.pixels >= _pageController.position.maxScrollExtent - 200 ) {

        siguientePagina();

      }

    });

    return Container(
      height: _screenSize.height * 0.30,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemCount: peliculas.length,
        itemBuilder: ( context, i ) => _tarjeta(context, peliculas[i])
      ),
    );

  }

  Widget _tarjeta(BuildContext context, Pelicula pelicula) {

    final tarjeta = Container(
      margin: EdgeInsets.only(right:15.0),
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: FadeInImage(
              image: NetworkImage( pelicula.getPosterImg() ),
              placeholder: AssetImage('assets/img/404.jpg.png'),
              fit: BoxFit.cover,
              height: 160.0,
            ),
          ),
          SizedBox(height: 2.0,),
          Text(
            pelicula.title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption
          )
        ],
      )
    );

    return GestureDetector(
      child: tarjeta,
      onTap: () {

        Navigator.pushNamed(context, 'detalle', arguments: pelicula);

      },
    );

  }

  List<Widget> _tarjetas(BuildContext context) {

    return peliculas.map((pelicula) {

      return Container(
        margin: EdgeInsets.only(right:15.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: FadeInImage(
                image: NetworkImage( pelicula.getPosterImg() ),
                placeholder: AssetImage('assets/img/404.jpg.png'),
                fit: BoxFit.cover,
                height: 160.0,
              ),
            ),
            SizedBox(height: 2.0,),
            Text(
              pelicula.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption
            )
          ],
        )
      );

    }).toList();

  }
}

