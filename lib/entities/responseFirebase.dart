import 'package:emotion_cam_360/entities/responseError.dart';

class Responsefirebase extends ResponseBodyOrError {
  final String url;

  Responsefirebase(super.success, super.message, super.code,
      {required this.url});
}
