import 'dart:io';
import 'dart:typed_data';

import 'package:chalkdart/chalk.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emotion_cam_360/entities/event.dart';
import 'package:emotion_cam_360/entities/video.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

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

//LEER BD
  Future<MyUser?> getMyUser() async {
    final snapshot = await firestore.doc('user/${currentUser.uid}').get();
    if (snapshot.exists) return MyUser.fromFirebaseMap(snapshot.data()!);
    return null;
  }

  //GUARDAR EN BD DE FIRESTORE
  Future<String> saveMyVideoProvider(
      Uint8List? video, String rutaVideo, EventEntity currentEvent) async {
    print(chalk.brightGreen('ENTRO PROVIDER'));

    final DateTime now = DateTime.now();
    final int millSeconds = now.millisecondsSinceEpoch;
    final String month = now.month.toString();
    final String date = now.day.toString();
    final String storageId = ("VID_360_" + millSeconds.toString());
    final String today = ('$date - $month');

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

    return urlDownload;
  }

  Future<void> saveMyEventProvider(
      EventEntity newEvent, File? imageLogo) async {
    final ref = firestore.doc('user_${currentUser.uid}/${newEvent.id}');

    if (imageLogo != null) {
      final imagePath =
          '${currentUser.uid}/videos360/${path.basename(imageLogo.path)}';

      final storageRef = storage.ref(imagePath);
      await storageRef.putFile(imageLogo);
      final url = await storageRef.getDownloadURL();

      print(chalk.brightGreen('LOG AQUI $url'));

      await ref.set(
          newEvent.toFirebaseMap(overlay: url), SetOptions(merge: true));
    } else {
      await ref.set(newEvent.toFirebaseMap(), SetOptions(merge: true));
    }
  }
}
