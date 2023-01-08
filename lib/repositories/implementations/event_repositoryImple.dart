import 'dart:io';
import 'dart:typed_data';

import 'package:emotion_cam_360/data/db_data_source.dart';
import 'package:emotion_cam_360/entities/event.dart';
import 'package:emotion_cam_360/entities/video.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/firebase_provider-db.dart';

import '../abstractas/event_repository.dart';
import '../abstractas/video_repository.dart';

class EventRepositoryImple extends EventRepository {
  final provider = FirebaseProvider();
  //final RestDataSource _restDataSource;
  //final DbDataSource _dbDataSource;

  //@override
  //Future<MyUser?> getMyUser() => provider.getMyUser();

  //EventRepositoryImple(this._dbDataSource);
  //EventRepositoryImple(this._dbDataSource);

  @override
  Future<void> saveMyEvento(EventEntity newEvent, File? imageLogo) async {
    provider.saveMyEventProvider(newEvent, imageLogo);
  }

/*   @override
  Future<EventEntity> getNewEvent() async {
    final event =
        EventEntity("name.first", "last", "location", overlay: "Jues");
    await _dbDataSource.save(event);
    return event;
  }

  @override
  Future<List<EventEntity>> getAllEvents() async {
    return _dbDataSource.getAllEvents();
  }

  @override
  Future<bool> deleteEvent(EventEntity toDelete) async {
    final result = await _dbDataSource.delete(toDelete);
    return result == 1;
  } */
}
