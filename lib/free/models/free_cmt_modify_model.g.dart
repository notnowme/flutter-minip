// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'free_cmt_modify_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FreeCommentModifyModel _$FreeCommentModifyModelFromJson(
        Map<String, dynamic> json) =>
    FreeCommentModifyModel(
      ok: json['ok'] as bool,
      data: FreeCommentModifyDataModel.fromJson(
          json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FreeCommentModifyModelToJson(
        FreeCommentModifyModel instance) =>
    <String, dynamic>{
      'ok': instance.ok,
      'data': instance.data,
    };

FreeCommentModifyDataModel _$FreeCommentModifyDataModelFromJson(
        Map<String, dynamic> json) =>
    FreeCommentModifyDataModel(
      no: json['no'] as int,
      board_no: json['board_no'] as int,
      author_no: json['author_no'] as int,
      content: json['content'] as String,
      created_at: json['created_at'] as String,
      updated_at: json['updated_at'] as String,
    );

Map<String, dynamic> _$FreeCommentModifyDataModelToJson(
        FreeCommentModifyDataModel instance) =>
    <String, dynamic>{
      'no': instance.no,
      'board_no': instance.board_no,
      'author_no': instance.author_no,
      'content': instance.content,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
    };
