// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'free_write_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FreeWriteModel _$FreeWriteModelFromJson(Map<String, dynamic> json) =>
    FreeWriteModel(
      ok: json['ok'] as bool,
      data: FreeWriteDataModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FreeWriteModelToJson(FreeWriteModel instance) =>
    <String, dynamic>{
      'ok': instance.ok,
      'data': instance.data,
    };

FreeWriteDataModel _$FreeWriteDataModelFromJson(Map<String, dynamic> json) =>
    FreeWriteDataModel(
      no: json['no'] as int,
      author_no: json['author_no'] as int,
      title: json['title'] as String,
      content: json['content'] as String,
      created_at: json['created_at'] as String,
      updated_at: json['updated_at'] as String,
      author:
          FreeWriteAuthorModel.fromJson(json['author'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FreeWriteDataModelToJson(FreeWriteDataModel instance) =>
    <String, dynamic>{
      'no': instance.no,
      'author_no': instance.author_no,
      'title': instance.title,
      'content': instance.content,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'author': instance.author,
    };

FreeWriteAuthorModel _$FreeWriteAuthorModelFromJson(
        Map<String, dynamic> json) =>
    FreeWriteAuthorModel(
      no: json['no'] as int,
      id: json['id'] as String,
      nick: json['nick'] as String,
    );

Map<String, dynamic> _$FreeWriteAuthorModelToJson(
        FreeWriteAuthorModel instance) =>
    <String, dynamic>{
      'no': instance.no,
      'id': instance.id,
      'nick': instance.nick,
    };
