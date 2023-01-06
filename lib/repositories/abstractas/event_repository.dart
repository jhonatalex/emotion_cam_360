import 'dart:io';
import 'dart:typed_data';

import 'package:emotion_cam_360/entities/event.dart';
import 'package:emotion_cam_360/entities/video.dart';
import 'package:image_picker/image_picker.dart';

abstract class EventRepository {
  Future<void> saveMyEvento(EventEntity newEvent, File? value);
}
