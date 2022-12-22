import 'dart:typed_data';

import 'package:equatable/equatable.dart';

class VideoEntity extends Equatable {
  final String name;
  final String ruta;

  final String? video;

  const VideoEntity(this.name, this.ruta, {this.video});

  @override
  List<Object?> get props => [ruta];

  Map<String, Object?> toFirebaseMap({String? newVideo}) {
    return <String, Object?>{
      'name': name,
      'ruta': ruta,
      'video': newVideo ?? video,
    };
  }

  VideoEntity.fromFirebaseMap(Map<String, Object?> data)
      : name = data['name'] as String,
        ruta = data['ruta'] as String,
        video = data['video'] as String?;
}
