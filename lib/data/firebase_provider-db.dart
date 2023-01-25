import 'dart:io';
import 'dart:typed_data';
import 'package:chalkdart/chalk.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emotion_cam_360/entities/event.dart';
import 'package:emotion_cam_360/entities/responseFirebase.dart';

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
    final snapshot = await firestore.doc('user/${currentUser.uid}').get();
    if (snapshot.exists) return MyUser.fromFirebaseMap(snapshot.data()!);
    return null;
  }

  //GUARDAR EN BD
  Future<void> saveMyUser(MyUser user) async {
    print(chalk.brightGreen('entro AL PROVIDER $user'));

    final ref = firestore.doc('user/${user.email}');
    await ref.set(user.toFirebaseMap(), SetOptions(merge: true));
  }

//____________VIDEOS______________________________________________________//
  //GUARDAR EN BD DE FIRESTORE
  Future<Responsefirebase> saveMyVideoProvider(
      Uint8List? video, String rutaVideo, EventEntity currentEvent) async {
    print(chalk.brightGreen('ENTRO PROVIDER'));

    final DateTime now = DateTime.now();
    final int millSeconds = now.millisecondsSinceEpoch;
    final String month = now.month.toString();
    final String date = now.day.toString();
    final String storageId = ("VID_360_" + millSeconds.toString());
    final String today = ('$date - $month');

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

      print(chalk.brightGreen(urlDownload));

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
      final url = await storageRef.getDownloadURL();

      print(chalk.brightGreen('LOG AQUI $url'));

      await ref.set(newEvent.toFirebaseMap(), SetOptions(merge: true));
    } else {
      await ref.set(newEvent.toFirebaseMap(), SetOptions(merge: true));
    }
  }

  Future<EventEntity?> getMyEventProvider(idEvent) async {
    print(chalk.brightGreen('entro PROVIDER $idEvent'));
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
      querySnapshot.docs.forEach((doc) {
        //print(doc["id"]);
      });
    });

    return listaEventos;
  }
}
