import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:jaen_ruiz_3_2021_p1/component/loader_component.dart';
import 'package:jaen_ruiz_3_2021_p1/helpers/api_helper_anime.dart';
import 'package:jaen_ruiz_3_2021_p1/models/get_all.dart';
import 'package:jaen_ruiz_3_2021_p1/models/response_api.dart';
import 'package:jaen_ruiz_3_2021_p1/screens/anime_details.dart';

class anime_home_screen extends StatefulWidget {
  const anime_home_screen({ Key? key }) : super(key: key);

  @override
  _anime_home_screen_state createState() => _anime_home_screen_state();
}

class _anime_home_screen_state extends State<anime_home_screen> {

  List<get_all> _animes = [];
  bool _showLoader = false;
  bool _isFiltered = false;
  String _search = '';


  @override
  void initState() {
    super.initState();
    _getAllAnime();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('The best Animes'),
        actions: <Widget>[
          _isFiltered
              ? IconButton(
                  onPressed: _remove_Filter, icon: Icon(Icons.filter_none))
              : IconButton(onPressed: _show_Filter, icon: Icon(Icons.filter_alt))
        ],
      ),
      body: Center(
        child: _showLoader ? LoaderComponent(text: 'Por favor espere...') : _getContent(),
      ),
    );
  }

  Widget _getContent() {
    return _animes.length == 0 ? _noContent() : _getListView();
  }

  Widget _noContent() {
    return Center(
      child: Container(
        margin: EdgeInsets.all(30),
        child: Text('No hay animes registrados',
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }

  Future<Null> _getAllAnime() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      await showAlertDialog(
          context: context,
          title: 'Error',
          message: 'Verifica que estes conectado a internet.',
          actions: <AlertDialogAction>[
            AlertDialogAction(key: null, label: 'Aceptar'),
          ]);
      return;
    }

    response_api response = await api_helper_anime.getAllAnime();

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
      _animes = response.result;
    });
  }

    Widget _getListView() {
    return RefreshIndicator(
      onRefresh: _getAllAnime,
      child: ListView(
        children: _animes.map((e) {
          return Card(
            color: Colors.cyan.shade100,
            child: InkWell(
              onTap: () => _godetailanime(e),
              child: Container(
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                            e.anime_img,
                            width: 70,
                          ),
                        ),
                        Text(
                          e.anime_name,
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios),
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
  void _show_Filter() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: Text('Filtrar Animes'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Escriba las primeras letras del anime'),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  autofocus: true,
                  decoration: InputDecoration(
                      hintText: 'Criterio de búsqueda...',
                      labelText: 'Buscar',
                      suffixIcon: Icon(Icons.search)),
                  onChanged: (value) {
                    _search = value;
                  },
                )
              ],
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Cancelar')),
              TextButton(onPressed: () => _filter(), child: Text('Filtrar')),
            ],
          );
        });
  }

  void _remove_Filter() {
    setState(() {
      _isFiltered = false;
    });
    _getAllAnime();
  }

  void _filter() {
    if (_search.isEmpty) {
      return;
    }
    List<get_all> filteredList = [];
    for (var anime in _animes) {
      if (anime.anime_name.toLowerCase().contains(_search.toLowerCase())) {
        filteredList.add(anime);
      }
    }

    setState(() {
      _animes = filteredList;
      _isFiltered = true;
    });

    Navigator.of(context).pop();
  }
  
  void _godetailanime(get_all anime) async {
    String? result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => anime_details(anime: anime)));
    if (result == 'yes') {
      _getAllAnime();
    }
  }
}
