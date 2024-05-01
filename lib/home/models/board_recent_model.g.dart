// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board_recent_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecentBoardModel _$RecentBoardModelFromJson(Map<String, dynamic> json) =>
    RecentBoardModel(
      ok: json['ok'] as bool,
      data: (json['data'] as List<dynamic>)
          .map((e) => RecentBoardDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RecentBoardModelToJson(RecentBoardModel instance) =>
    <String, dynamic>{
      'ok': instance.ok,
      'data': instance.data,
    };

RecentBoardDataModel _$RecentBoardDataModelFromJson(
        Map<String, dynamic> json) =>
    RecentBoardDataModel(
      no: json['no'] as int,
      author_no: json['author_no'] as int,
      title: json['title'] as String,
      content: json['content'] as String,
      created_at: json['created_at'] as String,
      updated_at: json['updated_at'] as String,
      author: RecentBoardAuthorModel.fromJson(
          json['author'] as Map<String, dynamic>),
      comments: (json['comments'] as List<dynamic>)
          .map((e) =>
              RecentBoardCommentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RecentBoardDataModelToJson(
        RecentBoardDataModel instance) =>
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

RecentBoardAuthorModel _$RecentBoardAuthorModelFromJson(
        Map<String, dynamic> json) =>
    RecentBoardAuthorModel(
      id: json['id'] as String,
      nick: json['nick'] as String,
    );

Map<String, dynamic> _$RecentBoardAuthorModelToJson(
        RecentBoardAuthorModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nick': instance.nick,
    };

RecentBoardCommentModel _$RecentBoardCommentModelFromJson(
        Map<String, dynamic> json) =>
    RecentBoardCommentModel(
      author_no: json['author_no'] as int,
    );

Map<String, dynamic> _$RecentBoardCommentModelToJson(
        RecentBoardCommentModel instance) =>
    <String, dynamic>{
      'author_no': instance.author_no,
    };
