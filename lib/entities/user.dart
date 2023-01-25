import 'package:equatable/equatable.dart';

class MyUser extends Equatable {
  final String id;
  final String email;
  final bool status;

  const MyUser(this.id, this.email, {required this.status});
  @override
  List<Object?> get props => [id];

  Map<String, Object?> toFirebaseMap({bool? newstatus}) {
    return <String, Object?>{
      'id': id,
      'email': email,
      'status': status,
    };
  }

  MyUser.fromFirebaseMap(Map<String, Object?> data)
      : id = data['id'] as String,
        email = data['email'] as String,
        status = data['status'] as bool;
}
