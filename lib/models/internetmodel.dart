import 'dart:async';

class InternetModel {

  String InternetStatus;
  StreamSubscription? InternetStream;

  InternetModel({
    required this.InternetStatus,
    this.InternetStream,
  });
}
