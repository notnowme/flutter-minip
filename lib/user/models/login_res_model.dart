import 'package:json_annotation/json_annotation.dart';

part 'login_res_model.g.dart';

@JsonSerializable()
class LoginResModel {
  final bool ok;
  final LoginDataModel data;

  LoginResModel({required this.ok, required this.data});

  factory LoginResModel.fromJson(Map<String, dynamic> json) =>
      _$LoginResModelFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResModelToJson(this);
}

@JsonSerializable()
class LoginDataModel {
  final int no;
  final String id, nick, token;

  LoginDataModel(
      {required this.no,
      required this.id,
      required this.nick,
      required this.token});

  factory LoginDataModel.fromJson(Map<String, dynamic> json) =>
      _$LoginDataModelFromJson(json);
  Map<String, dynamic> toJson() => _$LoginDataModelToJson(this);
}
