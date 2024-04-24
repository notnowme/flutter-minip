// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'free_modify_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FreeModifyModel _$FreeModifyModelFromJson(Map<String, dynamic> json) =>
    FreeModifyModel(
      ok: json['ok'] as bool,
      data: FreeModifyDataModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FreeModifyModelToJson(FreeModifyModel instance) =>
    <String, dynamic>{
      'ok': instance.ok,
      'data': instance.data,
    };

FreeModifyDataModel _$FreeModifyDataModelFromJson(Map<String, dynamic> json) =>
    FreeModifyDataModel(
      no: json['no'] as int,
      author_no: json['author_no'] as int,
      title: json['title'] as String,
      content: json['content'] as String,
      created_at: json['created_at'] as String,
      updated_at: json['updated_at'] as String,
    );

Map<String, dynamic> _$FreeModifyDataModelToJson(
        FreeModifyDataModel instance) =>
    <String, dynamic>{
      'no': instance.no,
      'author_no': instance.author_no,
      'title': instance.title,
      'content': instance.content,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
    };
