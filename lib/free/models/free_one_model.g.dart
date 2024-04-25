// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'free_one_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FreeOneModel _$FreeOneModelFromJson(Map<String, dynamic> json) => FreeOneModel(
      ok: json['ok'] as bool,
      data: FreeOneDataModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FreeOneModelToJson(FreeOneModel instance) =>
    <String, dynamic>{
      'ok': instance.ok,
      'data': instance.data,
    };

FreeOneDataModel _$FreeOneDataModelFromJson(Map<String, dynamic> json) =>
    FreeOneDataModel(
      no: json['no'] as int,
      author_no: json['author_no'] as int,
      title: json['title'] as String,
      content: json['content'] as String,
      created_at: json['created_at'] as String,
      updated_at: json['updated_at'] as String,
      author:
          FreeOneAuthorModel.fromJson(json['author'] as Map<String, dynamic>),
      comments: (json['comments'] as List<dynamic>)
          .map((e) => FreeOneCommentsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FreeOneDataModelToJson(FreeOneDataModel instance) =>
    <String, dynamic>{
      'no': instance.no,
      'author_no': instance.author_no,
      'title': instance.title,
      'content': instance.content,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'author': instance.author,
      'comments': instance.comments,
    };

FreeOneAuthorModel _$FreeOneAuthorModelFromJson(Map<String, dynamic> json) =>
    FreeOneAuthorModel(
      id: json['id'] as String,
      nick: json['nick'] as String,
    );

Map<String, dynamic> _$FreeOneAuthorModelToJson(FreeOneAuthorModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nick': instance.nick,
    };

FreeOneCommentsModel _$FreeOneCommentsModelFromJson(
        Map<String, dynamic> json) =>
    FreeOneCommentsModel(
      no: json['no'] as int,
      board_no: json['board_no'] as int,
      content: json['content'] as String,
      created_at: json['created_at'] as String,
      updated_at: json['updated_at'] as String,
      author:
          FreeOneAuthorModel.fromJson(json['author'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FreeOneCommentsModelToJson(
        FreeOneCommentsModel instance) =>
    <String, dynamic>{
      'no': instance.no,
      'board_no': instance.board_no,
      'content': instance.content,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'author': instance.author,
    };
