import 'package:astronomy_pictures/Models/AstronomyPicture.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class PictureViewModel with ChangeNotifier {
  final Connectivity _connectivity = Connectivity();
  ConnectionStatus connectionStatus = ConnectionStatus.pending;
  static const _apiKey = 'pNxrfoqFtRU6kQOYxE9fSwY2m6axss6WwswmuCiB';
  RegExp datesValidation =
      RegExp(r"^\d{4}\-(0[1-9]|1[012])\-(0[1-9]|[12][0-9]|3[01])$");
  bool _isLoadingExtra = false;


  List<AstronomyPicture> _pictures = [];


  List<AstronomyPicture> get pictures => _pictures;
  bool get isLoadingExtra => _isLoadingExtra;

  PictureViewModel() {
    fetchPictures();
  }
  PictureViewModel.init();


  fetchPictures({bool loadingExtra = false}) async {
    _isLoadingExtra = loadingExtra;
    notifyListeners();

    List<AstronomyPicture> pictures = [];

    try {
      var response = await Dio().get('https://api.nasa.gov/planetary/'
          'apod?api_key=$_apiKey'
         '&count=10'
          ).catchError((e){
            print('*************\n\nError: $e\n\n');
      });

      var list = response.data as List;

      pictures =
          list.map((picture) => AstronomyPicture.fromJson(picture)).toList();
    } catch (e) {
      debugPrint(e.toString());
    }

    _pictures.addAll(pictures);
    _isLoadingExtra = false;
    print(_pictures.length);
    notifyListeners();
  }

  Future checkConnection() async {
    ConnectivityResult connectivityResult =
        await _connectivity.checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      connectionStatus = ConnectionStatus.connected;
    } else if (connectivityResult == ConnectivityResult.none) {
      connectionStatus = ConnectionStatus.notConnected;
    }
  }
}

enum ConnectionStatus { connected, notConnected, pending }
