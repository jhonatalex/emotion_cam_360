import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emotion_cam_360/entities/video.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

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

  get scanner => null;

//LEER BD
  Future<MyUser?> getMyUser() async {
    final snapshot = await firestore.doc('user/${currentUser.uid}').get();
    if (snapshot.exists) return MyUser.fromFirebaseMap(snapshot.data()!);
    return null;
  }

  //GUARDAR EN BD
  Future<void> saveMyVideoProvider(
      VideoEntity videoEntity, Uint8List? video) async {
    print("ENTRO PROVIDER");
    print(videoEntity);

    final ref = firestore.doc('videos_colletion/${videoEntity.ruta}');

    if (video != null) {
      final imagePath =
          '${videoEntity.name}/videos360/${path.basename(videoEntity.ruta)}';
      final storageRef = storage.ref(imagePath);

      await storageRef.putData(video);

      final url = await storageRef.getDownloadURL();

      print(url);

      await ref.set(
          videoEntity.toFirebaseMap(newVideo: url), SetOptions(merge: true));
    } else {
      await ref.set(videoEntity.toFirebaseMap(), SetOptions(merge: true));
    }
  }
}
