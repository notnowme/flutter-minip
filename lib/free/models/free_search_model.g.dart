// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'free_search_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FreeSearchModel _$FreeSearchModelFromJson(Map<String, dynamic> json) =>
    FreeSearchModel(
      board: json['board'] as String,
      cat: json['cat'] as String,
      keyword: json['keyword'] as String,
      page: json['page'] as int,
    );

Map<String, dynamic> _$FreeSearchModelToJson(FreeSearchModel instance) =>
    <String, dynamic>{
      'board': instance.board,
      'cat': instance.cat,
      'keyword': instance.keyword,
      'page': instance.page,
    };
