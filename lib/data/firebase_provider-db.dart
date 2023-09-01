import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emotion_cam_360/entities/event.dart';
import 'package:emotion_cam_360/entities/responseFirebase.dart';
import 'package:emotion_cam_360/entities/suscripcion.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../entities/user.dart';
import 'package:path/path.dart' as path;

class FirebaseProvider {
  FirebaseFirestore get firestore => FirebaseFirestore.instance;
  FirebaseStorage get storage => FirebaseStorage.instance;
  late var urlDownload = '';

  User get currentUser {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) throw Exception('Not authenticated exception');
    return user;
  }

//____________________USUARIO______________________________________//
//LEER BD
  Future<MyUser?> getMyUser() async {
    //cree otro porque este usa uid y no me daba la data sino Null
    final snapshot = await firestore.doc('user/${currentUser.uid}').get();
    if (snapshot.exists) return MyUser.fromFirebaseMap(snapshot.data()!);
    return null;
  }

  Future<MyUser?> getMyUser2() async {
    final snapshot = await firestore.doc('user/${currentUser.email}').get();
    if (snapshot.exists) return MyUser.fromFirebaseMap(snapshot.data()!);
    return null;
  }

  //GUARDAR EN BD
  Future<void> saveMyUser(MyUser user) async {
    final ref = firestore.doc('user/${user.email}');
    await ref.set(user.toFirebaseMap(), SetOptions(merge: true));
  }

  Future<void> setSubscriptionDate(MyUser user) async {
    final ref = firestore.doc('user/${user.email}');
    await ref.set(user.toFirebaseMap(), SetOptions(merge: true));
  }

//____________VIDEOS______________________________________________________//
  //GUARDAR EN BD DE FIRESTORE
  Future<Responsefirebase> saveMyVideoProvider(
      Uint8List? video, String rutaVideo, EventEntity currentEvent) async {
    late Responsefirebase responsefirebase;

    try {
      var listaVideos = [];

      if (currentEvent.videos != null) {
        listaVideos = currentEvent.videos!;
      }

      final ref = firestore.doc('user_${currentUser.uid}/${currentEvent.id}');

      if (video != null) {
        final videoPath =
            '${currentUser.uid}/videos360/${path.basename(rutaVideo)}';

        final storageRef = storage.ref(videoPath);
        await storageRef.putData(
            video, SettableMetadata(contentType: 'video/mp4'));
        urlDownload = await storageRef.getDownloadURL();
        listaVideos.add(urlDownload);

        await ref.set(currentEvent.toFirebaseMap(videos: listaVideos),
            SetOptions(merge: true));
      } else {
        await ref.set(currentEvent.toFirebaseMap(), SetOptions(merge: true));
      }

      responsefirebase = Responsefirebase(true, "ok", 200, url: urlDownload);
    } catch (e) {
      responsefirebase =
          Responsefirebase(false, e.toString(), 400, url: "urlDownload");
    }

    return responsefirebase;
  }

//_____________EVENTOS_____________________________________________//

  Future<void> saveMyEventProvider(
      EventEntity newEvent, File? imageLogo, File? mp3file) async {
    final ref = firestore.doc('user_${currentUser.uid}/${newEvent.id}');

    if (imageLogo != null) {
      final imagePath =
          '${currentUser.uid}/videos360/${path.basename(imageLogo.path)}';

      final storageRef = storage.ref(imagePath);
      await storageRef.putFile(imageLogo);

      await ref.set(newEvent.toFirebaseMap(), SetOptions(merge: true));
    } else {
      await ref.set(newEvent.toFirebaseMap(), SetOptions(merge: true));
    }
  }

  Future<EventEntity?> getMyEventProvider(idEvent) async {
    final snapshot =
        await firestore.doc('user_${currentUser.uid}/$idEvent').get();

    if (snapshot.exists) return EventEntity.fromFirebaseMap(snapshot.data()!);
    return null;
  }

  Future<List> getAllMyEventProvider() async {
    var listaEventos = [];
    await firestore
        .collection('user_${currentUser.uid}')
        .get()
        .then((QuerySnapshot querySnapshot) {
      listaEventos = querySnapshot.docs;
      // ignore: unused_local_variable
      /*   for (var doc in querySnapshot.docs) {
        //print(doc["id"]);
      } */
    });

    return listaEventos;
  }

//____________SUBSCRIPCION DATA___________________________________________//

  Future<List<Suscripcion>> getAllTypeSuscripcionProvider() async {
    List<Suscripcion> listasuscripciones = [];

    final querySnapshot = await firestore.collection('suscripcion').get();
    final docs = querySnapshot.docs;

    //CONVERTIR RESPUESTA EN ENTITIES
    for (var doc in docs) {
      final subsNew = Suscripcion(
          doc["name"],
          doc["typeDate"],
          doc["featureOne"],
          doc["featureTwo"],
          doc["featureThree"],
          doc["legal"],
          doc["saving"],
          doc["price"]);

      listasuscripciones.add(subsNew);
    }

    return listasuscripciones;
  }
}
