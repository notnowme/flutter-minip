// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'free_cmt_write_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FreeCommentWriteModel _$FreeCommentWriteModelFromJson(
        Map<String, dynamic> json) =>
    FreeCommentWriteModel(
      ok: json['ok'] as bool,
      data: FreeCommentWriteDataModel.fromJson(
          json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FreeCommentWriteModelToJson(
        FreeCommentWriteModel instance) =>
    <String, dynamic>{
      'ok': instance.ok,
      'data': instance.data,
    };

FreeCommentWriteDataModel _$FreeCommentWriteDataModelFromJson(
        Map<String, dynamic> json) =>
    FreeCommentWriteDataModel(
      no: json['no'] as int,
      board_no: json['board_no'] as int,
      author_no: json['author_no'] as int,
      content: json['content'] as String,
      created_at: json['created_at'] as String,
      updated_at: json['updated_at'] as String,
      author: FreeCommentWriteAuthorModel.fromJson(
          json['author'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FreeCommentWriteDataModelToJson(
        FreeCommentWriteDataModel instance) =>
    <String, dynamic>{
      'no': instance.no,
      'board_no': instance.board_no,
      'author_no': instance.author_no,
      'content': instance.content,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'author': instance.author,
    };

FreeCommentWriteAuthorModel _$FreeCommentWriteAuthorModelFromJson(
        Map<String, dynamic> json) =>
    FreeCommentWriteAuthorModel(
      id: json['id'] as String,
      nick: json['nick'] as String,
    );

Map<String, dynamic> _$FreeCommentWriteAuthorModelToJson(
        FreeCommentWriteAuthorModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nick': instance.nick,
    };
