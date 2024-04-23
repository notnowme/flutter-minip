import 'package:json_annotation/json_annotation.dart';

part 'user_nick_modify_model.g.dart';

@JsonSerializable()
class UserNickModifyModel {
  final bool ok;
  final NickModifyResDataModel data;

  UserNickModifyModel({
    required this.ok,
    required this.data,
  });

  factory UserNickModifyModel.fromJson(Map<String, dynamic> json) =>
      _$UserNickModifyModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserNickModifyModelToJson(this);
}

@JsonSerializable()
class NickModifyResDataModel {
  final int no;
  final String id, nick;

  NickModifyResDataModel({
    required this.no,
    required this.id,
    required this.nick,
  });

  factory NickModifyResDataModel.fromJson(Map<String, dynamic> json) =>
      _$NickModifyResDataModelFromJson(json);
  Map<String, dynamic> toJson() => _$NickModifyResDataModelToJson(this);
}
