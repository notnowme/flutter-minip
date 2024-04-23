// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      no: json['no'] as String,
      id: json['id'] as String,
      nick: json['nick'] as String,
      accessToken: json['accessToken'] as String,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'no': instance.no,
      'id': instance.id,
      'nick': instance.nick,
      'accessToken': instance.accessToken,
    };
