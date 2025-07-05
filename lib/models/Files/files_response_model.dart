// To parse this JSON data, do
//
//     final fileResponseModel = fileResponseModelFromJson(jsonString);

import 'package:rajesh_dada_padvi/models/Files/image_response_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'files_response_model.g.dart';

FileResponseModel fileResponseModelFromJson(String str) => FileResponseModel.fromJson(json.decode(str));

String fileResponseModelToJson(FileResponseModel data) => json.encode(data.toJson());

@JsonSerializable()
class FileResponseModel {
    @JsonKey(name: "files")
    List<ImageResponseModel>? files;

    FileResponseModel({
        this.files,
    });

    factory FileResponseModel.fromJson(Map<String, dynamic> json) => _$FileResponseModelFromJson(json);

    Map<String, dynamic> toJson() => _$FileResponseModelToJson(this);
}