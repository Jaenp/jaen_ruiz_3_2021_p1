import 'dart:ui';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:jaen_ruiz_3_2021_p1/component/loader_component.dart';
import 'package:jaen_ruiz_3_2021_p1/helpers/api_helper_anime.dart';
import 'package:jaen_ruiz_3_2021_p1/models/get_all.dart';
import 'package:jaen_ruiz_3_2021_p1/models/get_anime_details.dart';
import 'package:jaen_ruiz_3_2021_p1/models/response_api.dart';

class anime_details extends StatefulWidget {
  final get_all anime;

  anime_details({required this.anime});

  @override
  _anime_detailsState createState() => _anime_detailsState();
}

class _anime_detailsState extends State<anime_details> {
  bool _showLoader = false;
  List<get_anime_details> _animeDetails = [];
  late get_all _anime;

  @override
  void initState() {
    super.initState();
    _anime = widget.anime;
    _getAnime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(_anime.anime_name),
      ),
      body: Center(
        child: 
             _getContent(),
      ),
    );
  }

  Widget _showAnimeInfo() {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(5),
      color: Colors.white10,
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.vertical(),
                child: CachedNetworkImage(
                  imageUrl: _anime.anime_img,
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  fit: BoxFit.cover,
                  height: 300,
                  width: 300,
                  alignment: Alignment.topCenter,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<Null> _getAnime() async {
    setState(() {
      _showLoader = true;
    });

    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        _showLoader = false;
      });
      await showAlertDialog(
          context: context,
          title: 'Error',
          message: 'Se esta verificando que estes conectado a internet.',
          actions: <AlertDialogAction>[
            AlertDialogAction(key: null, label: 'Aceptar'),
          ]);
      return;
    }

    response_api response = await api_helper_anime.getAnime(_anime.anime_name);

    setState(() {
      _showLoader = false;
    });

    if (!response.isSuccess) {
      await showAlertDialog(
          context: context,
          title: 'Error',
          message: response.message,
          actions: <AlertDialogAction>[
            AlertDialogAction(key: null, label: 'Aceptar'),
          ]);
      return;
    }

    setState(() {
      _animeDetails = response.result;
    });
  }

  Widget _getContent() {
    return Column(
      children: <Widget>[
        _showAnimeInfo(),
        Expanded(
          child: _animeDetails.length == 0 ? _noContent() : _getListView(),
        ),
      ],
    );
  }

  Widget _getListView() {
    return RefreshIndicator(
      onRefresh: _getAnime,
      child: ListView(
        children: _animeDetails.map((e) {
          return Card(
            color: Colors.white10,
            child: InkWell(
              child: Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(5),
                child: Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          e.details,
                          style: TextStyle(
                              fontSize: 25,
                              fontStyle: FontStyle.normal,
                              color: Colors.black),
                        ),
                        Icon(Icons.bakery_dining_sharp, color: Colors.white)
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _noContent() {
    return Center(
      child: Container(
        margin: EdgeInsets.all(20),
        child: Text(
          'El anime no tiene detalles registrados.',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
  
}