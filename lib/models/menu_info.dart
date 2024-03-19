import 'package:rive/rive.dart';

class RiveModel {
  final String src, artboard, titel;
  late SMIBool? status;

  RiveModel({
    required this.src,
    required this.artboard,
    required this.titel,
    this.status,
  });

  set setStatus(SMIBool state) {
    status = state;
  }
}
