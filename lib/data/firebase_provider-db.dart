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

class FirebaseProvider extends GetxController {
  Rx<UploadTask?> uploadTask = Rx(null);

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
    print(chalk.brightGreen('ENTRO PROVIDER'));
    print(chalk.brightGreen('LOG AQUI $videoEntity'));

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

    //var ref = storage.ref().child("videos").child(today).child(storageId);
    //await ref.putData(video!);
    //var url = await ref.getDownloadURL();

    //UploadTask? uploadTask;
    //String url;
    var ref = storage.ref().child("videos").child(today).child(storageId);
    uploadTask.value = ref.putData(video!);

    final snapshot =
        await uploadTask.value!.whenComplete(() {}).catchError((onError) {
      print(onError);
    });

    final urlDownload = await snapshot.ref.getDownloadURL();

    uploadTask.value = null;
    return urlDownload;
    //final String url = downloadUrl.toString();
  }

  /* Future<void> saveMyEventProvider(
      EventEntity newEvent, File? imageLogo) async {
    final ref = firestore.doc('evento/${currentUser.uid}');

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
  } */

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
