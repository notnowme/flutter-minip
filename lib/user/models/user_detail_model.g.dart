// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDetailModel _$UserDetailModelFromJson(Map<String, dynamic> json) =>
    UserDetailModel(
      ok: json['ok'] as bool,
      data: UserDetailDataModel.fromJson(json['data'] as Map<String, dynamic>),
      freeBoardCount: json['freeBoardCount'] as int,
      qnaBoardCount: json['qnaBoardCount'] as int,
      freeCommentCount: json['freeCommentCount'] as int,
      qnaCommentCount: json['qnaCommentCount'] as int,
    );

Map<String, dynamic> _$UserDetailModelToJson(UserDetailModel instance) =>
    <String, dynamic>{
      'ok': instance.ok,
      'data': instance.data,
      'freeBoardCount': instance.freeBoardCount,
      'qnaBoardCount': instance.qnaBoardCount,
      'freeCommentCount': instance.freeCommentCount,
      'qnaCommentCount': instance.qnaCommentCount,
    };

UserDetailDataModel _$UserDetailDataModelFromJson(Map<String, dynamic> json) =>
    UserDetailDataModel(
      no: json['no'] as int,
      id: json['id'] as String,
      nick: json['nick'] as String,
      created_at: json['created_at'] as String,
    );

Map<String, dynamic> _$UserDetailDataModelToJson(
        UserDetailDataModel instance) =>
    <String, dynamic>{
      'no': instance.no,
      'id': instance.id,
      'nick': instance.nick,
      'created_at': instance.created_at,
    };
