import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class MyUser extends Equatable {
  final String id;
  final String email;
  bool verified; 
  Timestamp date;


  MyUser(this.id, this.email, this.verified, {required this.date});
  @override
  List<Object?> get props => [id];

  Map<String, Object?> toFirebaseMap({String? newdate}) {
    return <String, Object?>{
      'id': id,
      'email': email,
      'verified':verified,
      'date': date,
    };
  }

  MyUser.fromFirebaseMap(Map<String, Object?> data)
      : id = data['id'] as String,
        email = data['email'] as String,
        verified = data['verified'] as bool,
        date = data['date'] as Timestamp;
}
