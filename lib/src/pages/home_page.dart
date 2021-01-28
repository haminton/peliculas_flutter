import 'package:flutter/material.dart';

import 'package:peliculas/src/providers/peliculas_provider.dart';
import 'package:peliculas/src/search/search_delegate.dart';

import 'package:peliculas/src/widgets/card_swiper_widget.dart';
import 'package:peliculas/src/widgets/movie_horizontal.dart';


class HomePage extends StatelessWidget {

  final peliculasProviders = PeliculasProviders();

  @override
  Widget build(BuildContext context) {

    peliculasProviders.getPopulares();


    return Scaffold(
      appBar: AppBar(
        title: Text('Peliculas'),
        backgroundColor: Colors.indigoAccent,
        centerTitle: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context, 
                delegate: DataSearch(),
                //query: 'hola'
              );
            }
          ),
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _swiperTarjetas(),
            _footer(context)
          ],
        ),
      )
    );
  }

  Widget _swiperTarjetas() {

    return FutureBuilder(
      future: peliculasProviders.getEnCine(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {

        if (snapshot.hasData) {
          return CardSwiper(peliculas: snapshot.data);
        } else {
          return Container(
            height: 400.0,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  Widget _footer( BuildContext context) {

    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(bottom: 10.0, left: 10.0),
            child: Text('Populares', style: Theme.of(context).textTheme.subhead,)
          ),
          StreamBuilder(
            stream: peliculasProviders.popularesStream,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {

              if (snapshot.hasData) {
                return MovieHorizontal(
                  peliculas: snapshot.data,
                  siguientePagina: peliculasProviders.getPopulares,
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }
}