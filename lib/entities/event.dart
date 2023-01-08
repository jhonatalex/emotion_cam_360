import 'package:equatable/equatable.dart';

class EventEntity extends Equatable {
  final String id;
  final String name;
  final String overlay;
  final String music;
  final List? videos;

  const EventEntity(this.id, this.name, this.music,
      {required this.overlay, this.videos});

  @override
  List<Object?> get props => [id];

  List? get Urlvideos {
    return this.videos;
  }

  Map<String, Object?> toFirebaseMap({List? videos, String? overlay}) {
    return <String, Object?>{
      'id': id,
      'name': name,
      'overlay': overlay,
      'music': music,
      'videos': videos ?? videos,
    };
  }

  EventEntity.fromFirebaseMap(Map<String, Object?> data)
      : id = data['id'] as String,
        name = data['name'] as String,
        overlay = data['overlay'] as String,
        music = data['music'] as String,
        videos = data['videos'] as List?;

  EventEntity.fromMap(Map<String, dynamic> map)
      : id = map['id'] as String,
        name = map['name'] as String,
        overlay = map['overlay'] as String,
        music = map['music'] as String,
        videos = map['videos'] as List?;

  Map<String, dynamic> toMapForDb() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'overlay': overlay,
      'music': music,
      'videos': videos,
    };
  }
}
