import 'dart:io';

import 'package:emotion_cam_360/data/db_data_source.dart';
import 'package:emotion_cam_360/entities/event.dart';
import 'package:emotion_cam_360/entities/suscripcion.dart';

import '../../data/firebase_provider-db.dart';

import '../abstractas/event_repository.dart';

class EventRepositoryImple extends EventRepository {
  final provider = FirebaseProvider();

  //late final RestDataSource _restDataSource;
  late final DbDataSource _dbDataSource;

  //@override
  //Future<MyUser?> getMyUser() => provider.getMyUser();

  EventRepositoryImple(this._dbDataSource);
  //EventRepositoryImple(this._dbDataSource);

  @override
  Future<void> saveMyEvento(
      EventEntity newEvent, File? imageFile, File? mp3File) async {
    provider.saveMyEventProvider(newEvent, imageFile, mp3File);

    await _dbDataSource.save(newEvent);
  }

  @override
  Future<EventEntity?> getMyEventFirebase(String idEvent) async {
    return provider.getMyEventProvider(idEvent);
  }

  @override
  Future<List> getAllMyEventFirebase() async {
    return provider.getAllMyEventProvider();
  }

  Future<List<Suscripcion>> getAllSuscripcionesFirebase() async {
    return provider.getAllTypeSuscripcionProvider();
  }

/*  @override
  Future<EventEntity> getNewEvent() async {
    final event =
        EventEntity("name.first", "last", "location", overlay: "Jues");
    //await _dbDataSource.save(event);
    return event;
  }  */

  @override
  Future<List<EventEntity>> getAllEvents() async {
    return _dbDataSource.getAllEvents();
  }

  @override
  Future<EventEntity?> getLastEvent() async {
    // final eventFirebase = await getMyEventFirebase(eventBD.id);
    return _dbDataSource.getLastEvent();
  }

  @override
  Future<bool> deleteEvent(EventEntity toDelete) async {
    final result = await _dbDataSource.delete(toDelete);
    return result == 1;
  }
}
