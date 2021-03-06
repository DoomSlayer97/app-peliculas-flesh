import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_modelo.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';

class DataSearch extends SearchDelegate{

  String seleccionado = "";
  final peliculasProvider = PeliculasProvider();

  final peliculas = [
    'Spiderman',
    'Kick-Ass',
    'Batman',
    'Shazam',
    'Ironman',
    'Captian Murica'
  ];

  final peliculasRecientes = [
    'Spiderman',
    'Capitan America'
  ];
  
  @override
  List<Widget> buildActions(BuildContext context) {
      
    return [
      IconButton(
        icon: Icon( Icons.clear ),
        onPressed: () {

          query = '';

        },
      )
    ];

  }
  
  @override
  Widget buildLeading(BuildContext context ) {
    
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {

        close( context, null );

      },
    );

  }

  @override
  Widget buildResults( BuildContext context ) {
    
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.blueAccent,
        child: Text( seleccionado ),
      ),
    );

  }

  @override
  Widget buildSuggestions( BuildContext context ) {

    if( query.isEmpty ) {

      return Container();

    }

    return FutureBuilder(
      future: peliculasProvider.buscarPelicula(query),
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
        
        if( snapshot.hasData ) {

          final peliculas = snapshot.data;

          return ListView(
            children: peliculas.map((pelicula) {
              
              pelicula.uniqueId = '${pelicula.id}-busqueda';

              return ListTile(
                leading: Hero(
                  tag: pelicula.uniqueId,
                  child: FadeInImage(
                    image: NetworkImage( pelicula.getPosterImg() ),
                    placeholder: AssetImage('assets/img/loading.gif'),
                    width: 50.0,
                    fit: BoxFit.contain
                  ),
                ),
                title: Text(pelicula.title),
                subtitle: Text(pelicula.originalTitle),
                onTap: () {

                  close(context, null);

                  Navigator.pushNamed(context, 'detalle', arguments: pelicula);

                },
              );

            }).toList()
          );

        } else {
          return Center(
            child: CircularProgressIndicator()
          );
        }
      },
    );

    /* final listaSugerida = ( query.isEmpty )
                          ? peliculasRecientes
                          : peliculas.where(
                            (p) => p.toLowerCase().startsWith(query) 
                          ).toList();

    return ListView.builder(
      itemCount: listaSugerida.length,
      itemBuilder: ( context, i ) {

        return ListTile(
          leading: Icon(Icons.movie),
          title: Text(listaSugerida[i]),
          onTap: () {

            seleccionado = listaSugerida[i];

            showResults(context);

          },
        );

      },
    ); */

  }

}
