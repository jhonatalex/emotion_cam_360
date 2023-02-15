import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class MyUser extends Equatable {
  final String id;
  final String email;
  Timestamp date;
//Timestamp.now()
  MyUser(this.id, this.email, {required this.date});
  @override
  List<Object?> get props => [id];

  Map<String, Object?> toFirebaseMap({String? newdate}) {
    return <String, Object?>{
      'id': id,
      'email': email,
      'date': date,
    };
  }

  MyUser.fromFirebaseMap(Map<String, Object?> data)
      : id = data['id'] as String,
        email = data['email'] as String,
        date = data['date'] as Timestamp;
}
