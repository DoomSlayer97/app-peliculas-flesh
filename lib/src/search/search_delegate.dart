import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate{

  String seleccionado;

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

    final listaSugerida = ( query.isEmpty )
                          ? peliculasRecientes
                          : peliculas.where(
                            (p) => p.toLowerCase().startsWith(query) 
                          ).toList();

    return ListView.builder(
      itemCount: peliculasRecientes.length,
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
    );

  }

}
