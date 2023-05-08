import 'package:flutter/foundation.dart';
import '../../models/internetmodel.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class InternetProvider extends ChangeNotifier{

  Connectivity connectivity = Connectivity();

  InternetModel connectivityModel = InternetModel(InternetStatus: "WAITING..");

  void checkInternetConnectvity(){
    connectivityModel.InternetStream = connectivity.onConnectivityChanged.listen((ConnectivityResult connectivityResult) {
      switch(connectivityResult){
        case ConnectivityResult.wifi :
          connectivityModel.InternetStatus = "WIFI..";
          notifyListeners();
          break;
        case ConnectivityResult.mobile :
          connectivityModel.InternetStatus = "MOBILE PHONE..";
          notifyListeners();
          break;
        default:
          connectivityModel.InternetStatus = "WAITING..";
          notifyListeners();
          break;
      }
    });
  }
}