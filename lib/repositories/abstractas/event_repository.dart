import 'dart:io';

import 'package:emotion_cam_360/entities/event.dart';

abstract class EventRepository {
  //API FIREBASE
  Future<void> saveMyEvento(
      EventEntity newEvent, File? imageFile, File? mp3File);
  Future<EventEntity?> getMyEventFirebase(String idEvent);
  Future<List> getAllMyEventFirebase();

  //DB
  Future<List<EventEntity>> getAllEvents();
  Future<bool> deleteEvent(EventEntity toDelete);
  Future<EventEntity?> getLastEvent();
  //Future<EventEntity> getNewEvent();
}
