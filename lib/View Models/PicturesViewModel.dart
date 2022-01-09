import 'package:astronomy_pictures/Models/AstronomyPicture.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class PictureViewModel {
  final Connectivity _connectivity = Connectivity();
  ConnectionStatus connectionStatus = ConnectionStatus.pending;
  static const _apiKey = 'pNxrfoqFtRU6kQOYxE9fSwY2m6axss6WwswmuCiB';
  RegExp datesValidation =
      RegExp(r"^\d{4}\-(0[1-9]|1[012])\-(0[1-9]|[12][0-9]|3[01])$");

  Future<List<AstronomyPicture>> fetchPictures() async {
    List<AstronomyPicture> pictures = [];

    try {
      var response = await Dio()
          .get('https://api.nasa.gov/planetary/apod?api_key=$_apiKey&count=10');

      var list = response.data as List;

      pictures =
          list.map((picture) => AstronomyPicture.fromJson(picture)).toList();
    } catch (e) {
      debugPrint(e.toString());
    }

    return pictures;
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
