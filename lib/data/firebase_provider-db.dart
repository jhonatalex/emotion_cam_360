import 'dart:typed_data';

import 'package:chalkdart/chalk.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emotion_cam_360/entities/video.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;

import '../entities/user.dart';

class FirebaseProvider {
  User get currentUser {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception('Not authenticated exception');
    return user;
  }

  FirebaseFirestore get firestore => FirebaseFirestore.instance;
  FirebaseStorage get storage => FirebaseStorage.instance;

//LEER BD
  Future<MyUser?> getMyUser() async {
    final snapshot = await firestore.doc('user/${currentUser.uid}').get();
    if (snapshot.exists) return MyUser.fromFirebaseMap(snapshot.data()!);
    return null;
  }

  //GUARDAR EN BD DE FIRESTORE
  Future<String> saveMyVideoProvider(
      VideoEntity videoEntity, Uint8List? video) async {
    // if (kDebugMode) {
    print(chalk.brightGreen('ENTRO PROVIDER'));
    print(chalk.brightGreen('LOG AQUI $videoEntity'));
    // }
/* 
    final ref = firestore.doc('user/${currentUser.uid}');

    if (video != null) {
      final imagePath =
          '${videoEntity.name}/videos360/${path.basename(videoEntity.ruta)}';

      final storageRef = storage.ref(imagePath);
      await storageRef.putData(video);
      final url = await storageRef.getDownloadURL();

      print(chalk.brightGreen('LOG AQUI $url'));

      await ref.set(
          videoEntity.toFirebaseMap(newVideo: url), SetOptions(merge: true));
    } else {
      await ref.set(videoEntity.toFirebaseMap(), SetOptions(merge: true));
    }
  */

    final DateTime now = DateTime.now();
    final int millSeconds = now.millisecondsSinceEpoch;
    final String month = now.month.toString();
    final String date = now.day.toString();
    final String storageId = ("VID_360_" + millSeconds.toString());
    final String today = ('$month-$date');

    var ref = storage.ref().child("videos").child(today).child(storageId);
    await ref.putData(video!);
    var url = await ref.getDownloadURL();

    print(chalk.brightGreen('LOG AQUI $url'));

    return url;

    //final String url = downloadUrl.toString();
  }
}
