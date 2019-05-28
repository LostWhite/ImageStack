// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageModel _$ImageFromJson(Map<String, dynamic> json) {
  return ImageModel()
    ..id = json['id'] as String
    ..url = json['url'] as String
    ..like_count = json['like_count'] as String;
}

Map<String, dynamic> _$ImageToJson(ImageModel instance) => <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'like_count': instance.like_count
    };
