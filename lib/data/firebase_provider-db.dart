import 'dart:io';

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

  //GUARDAR EN BD
  Future<void> saveMyVideoProvider(VideoEntity videoEntity, File? video) async {
    final ref = firestore.doc('user/${currentUser.uid}');
    if (video != null) {
      final imagePath =
          '${currentUser.uid}/profile/${path.basename(video.path)}';
      final storageRef = storage.ref(imagePath);
      await storageRef.putFile(video);
      final url = await storageRef.getDownloadURL();
      await ref.set(
          videoEntity.toFirebaseMap(newVideo: url), SetOptions(merge: true));
    } else {
      await ref.set(videoEntity.toFirebaseMap(), SetOptions(merge: true));
    }
  }
}
