import 'dart:ffi';

import 'package:equatable/equatable.dart';

class EventEntity extends Equatable {
  final String id;
  final String name;
  final String intro;
  final String overlay;
  final int timeVideo;
  final String music;

  final List? videos;

  const EventEntity(
      this.id, this.name, this.overlay, this.intro, this.timeVideo, this.music,
      {this.videos});

  @override
  List<Object?> get props => [id];

  Map<String, Object?> toFirebaseMap({List? newVideos}) {
    return <String, Object?>{
      'id': id,
      'name': name,
      'intro': intro,
      'obverlay': overlay,
      'timeVideo': timeVideo,
      'music': music,
      'videos': newVideos ?? videos,
    };
  }

  EventEntity.fromFirebaseMap(Map<String, Object?> data)
      : id = data['id'] as String,
        name = data['name'] as String,
        intro = data['intro'] as String,
        overlay = data['overlay'] as String,
        timeVideo = data['timeVideo'] as int,
        music = data['music'] as String,
        videos = data['videos'] as List?;
}
