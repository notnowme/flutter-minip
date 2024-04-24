// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'free_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FreeListModel _$FreeListModelFromJson(Map<String, dynamic> json) =>
    FreeListModel(
      ok: json['ok'] as bool,
      data: (json['data'] as List<dynamic>)
          .map((e) => FreeListDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      boardsCount: json['boardsCount'] as int,
      allCounts: json['allCounts'] as int,
    );

Map<String, dynamic> _$FreeListModelToJson(FreeListModel instance) =>
    <String, dynamic>{
      'ok': instance.ok,
      'data': instance.data,
      'boardsCount': instance.boardsCount,
      'allCounts': instance.allCounts,
    };

FreeListDataModel _$FreeListDataModelFromJson(Map<String, dynamic> json) =>
    FreeListDataModel(
      no: json['no'] as int,
      author_no: json['author_no'] as int,
      title: json['title'] as String,
      content: json['content'] as String,
      created_at: json['created_at'] as String,
      updated_at: json['updated_at'] as String,
      author: FreeListDataAuthorModel.fromJson(
          json['author'] as Map<String, dynamic>),
      comments: (json['comments'] as List<dynamic>)
          .map((e) => FreeListCommentsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FreeListDataModelToJson(FreeListDataModel instance) =>
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

FreeListDataAuthorModel _$FreeListDataAuthorModelFromJson(
        Map<String, dynamic> json) =>
    FreeListDataAuthorModel(
      id: json['id'] as String,
      nick: json['nick'] as String,
    );

Map<String, dynamic> _$FreeListDataAuthorModelToJson(
        FreeListDataAuthorModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nick': instance.nick,
    };

FreeListCommentsModel _$FreeListCommentsModelFromJson(
        Map<String, dynamic> json) =>
    FreeListCommentsModel(
      author_no: json['author_no'] as int,
    );

Map<String, dynamic> _$FreeListCommentsModelToJson(
        FreeListCommentsModel instance) =>
    <String, dynamic>{
      'author_no': instance.author_no,
    };
