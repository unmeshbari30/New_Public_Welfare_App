// To parse this JSON data, do
//
//     final imageResponseModel = imageResponseModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'image_response_model.g.dart';

ImageResponseModel imageResponseModelFromJson(String str) => ImageResponseModel.fromJson(json.decode(str));

String imageResponseModelToJson(ImageResponseModel data) => json.encode(data.toJson());

@JsonSerializable()
class ImageResponseModel {
    @JsonKey(name: "_id")
    String? id;
    @JsonKey(name: "fileId")
    String? fileId;
    @JsonKey(name: "fileExtension")
    String? fileExtension;
    @JsonKey(name: "base64Data")
    String? base64Data;
    @JsonKey(name: "description")
    String? description;
    @JsonKey(name: "createdAt")
    DateTime? createdAt;
    @JsonKey(name: "updatedAt")
    DateTime? updatedAt;
    @JsonKey(name: "fileUrl")
    String? fileUrl;

    ImageResponseModel({
        this.id,
        this.fileId,
        this.fileExtension,
        this.base64Data,
        this.description,
        this.createdAt,
        this.updatedAt,
        this.fileUrl,
    });

    factory ImageResponseModel.fromJson(Map<String, dynamic> json) => _$ImageResponseModelFromJson(json);

    Map<String, dynamic> toJson() => _$ImageResponseModelToJson(this);
}
