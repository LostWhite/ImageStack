import 'package:json_annotation/json_annotation.dart';

part 'image.g.dart';

@JsonSerializable()
class ImageModel {
    ImageModel();

    String id;
    String url;
    String like_count;
    
    factory ImageModel.fromJson(Map<String,dynamic> json) => _$ImageFromJson(json);
    Map<String, dynamic> toJson() => _$ImageToJson(this);
}
