import 'package:equatable/equatable.dart';

class MyUser extends Equatable {
  final String id;
  final String email;
  final String evento;

  const MyUser(this.id, this.email, {required this.evento});
  @override
  List<Object?> get props => [id];

  Map<String, Object?> toFirebaseMap({String? newImage}) {
    return <String, Object?>{
      'id': id,
      'email': email,
      'evento': newImage ?? evento,
    };
  }

  MyUser.fromFirebaseMap(Map<String, Object?> data)
      : id = data['id'] as String,
        email = data['email'] as String,
        evento = data['evento'] as String;
}
