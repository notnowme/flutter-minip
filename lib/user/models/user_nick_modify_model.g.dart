// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_nick_modify_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserNickModifyModel _$UserNickModifyModelFromJson(Map<String, dynamic> json) =>
    UserNickModifyModel(
      ok: json['ok'] as bool,
      data:
          NickModifyResDataModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserNickModifyModelToJson(
        UserNickModifyModel instance) =>
    <String, dynamic>{
      'ok': instance.ok,
      'data': instance.data,
    };

NickModifyResDataModel _$NickModifyResDataModelFromJson(
        Map<String, dynamic> json) =>
    NickModifyResDataModel(
      no: json['no'] as int,
      id: json['id'] as String,
      nick: json['nick'] as String,
    );

Map<String, dynamic> _$NickModifyResDataModelToJson(
        NickModifyResDataModel instance) =>
    <String, dynamic>{
      'no': instance.no,
      'id': instance.id,
      'nick': instance.nick,
    };
