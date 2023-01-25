import 'dart:io';

import 'package:emotion_cam_360/data/firebase_provider-db.dart';
import '../../entities/user.dart';
import '../abstractas/my_user_repository.dart';

class MyUserRepositoryImp extends MyUserRepository {
  final provider = FirebaseProvider();

  @override
  Future<MyUser?> getMyUser() => provider.getMyUser();

  @override
  Future<void> saveMyUser(MyUser user) => provider.saveMyUser(user);
}
