// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'join_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JoinDataModel _$JoinDataModelFromJson(Map<String, dynamic> json) =>
    JoinDataModel(
      id: json['id'] as String,
      nick: json['nick'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$JoinDataModelToJson(JoinDataModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nick': instance.nick,
      'password': instance.password,
    };
