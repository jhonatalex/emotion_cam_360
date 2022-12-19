import 'package:equatable/equatable.dart';

class MyUser extends Equatable {
  final String id;
  final String name;
  final String rut;
  final String telefono;
  final String ciudad;
  final int balance;

  final String? image;

  const MyUser(
      this.id, this.name, this.telefono, this.ciudad, this.rut, this.balance,
      {this.image});

  @override
  List<Object?> get props => [id];

  Map<String, Object?> toFirebaseMap({String? newImage}) {
    return <String, Object?>{
      'id': id,
      'name': name,
      'rut': rut,
      'telefono': telefono,
      'ciudad': ciudad,
      'balance': balance,
      'image': newImage ?? image,
    };
  }

  MyUser.fromFirebaseMap(Map<String, Object?> data)
      : id = data['id'] as String,
        name = data['name'] as String,
        rut = data['rut'] as String,
        telefono = data['telefono'] as String,
        ciudad = data['ciudad'] as String,
        balance = data['balance'] as int,
        image = data['image'] as String?;
}
