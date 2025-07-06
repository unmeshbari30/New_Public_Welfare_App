// To parse this JSON data, do
//
//     final mlaInfoModel = mlaInfoModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'mla_info_model.g.dart';

MlaInfoModel mlaInfoModelFromJson(String str) => MlaInfoModel.fromJson(json.decode(str));

String mlaInfoModelToJson(MlaInfoModel data) => json.encode(data.toJson());

@JsonSerializable()
class MlaInfoModel {
    @JsonKey(name: "mlaInfo")
    MlaInfo? mlaInfo;

    MlaInfoModel({
        this.mlaInfo,
    });

    factory MlaInfoModel.fromJson(Map<String, dynamic> json) => _$MlaInfoModelFromJson(json);

    Map<String, dynamic> toJson() => _$MlaInfoModelToJson(this);
}

@JsonSerializable()
class MlaInfo {
    @JsonKey(name: "_id")
    String? id;
    @JsonKey(name: "aboutText")
    String? aboutText;
    @JsonKey(name: "fileUrl")
    String? fileUrl;
    @JsonKey(name: "base64Data")
    String? base64Data;
    @JsonKey(name: "createdAt")
    DateTime? createdAt;
    @JsonKey(name: "updatedAt")
    DateTime? updatedAt;
    @JsonKey(name: "__v")
    int? v;

    MlaInfo({
        this.id,
        this.aboutText,
        this.fileUrl,
        this.base64Data,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory MlaInfo.fromJson(Map<String, dynamic> json) => _$MlaInfoFromJson(json);

    Map<String, dynamic> toJson() => _$MlaInfoToJson(this);
}
