import 'dart:io';
import 'dart:typed_data';

import 'package:emotion_cam_360/entities/event.dart';
import 'package:emotion_cam_360/entities/video.dart';
import 'package:image_picker/image_picker.dart';

abstract class EventRepository {
  //API FIREBASE
  Future<void> saveMyEvento(
      EventEntity newEvent, File? imageFile, File? mp3File);
  Future<EventEntity?> getMyEventFirebase(String idEvent);
  Future<List> getAllMyEventFirebase();

  //DB
  Future<List<EventEntity>> getAllEvents();
  Future<bool> deleteEvent(EventEntity toDelete);
  Future<EventEntity> getNewEvent();
}
