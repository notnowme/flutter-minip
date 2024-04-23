import 'package:json_annotation/json_annotation.dart';

part 'login_req_model.g.dart';

@JsonSerializable()
class LoginReqModel {
  final String id, password;

  LoginReqModel({
    required this.id,
    required this.password,
  });

  factory LoginReqModel.fromJson(Map<String, dynamic> json) =>
      _$LoginReqModelFromJson(json);
  Map<String, dynamic> toJson() => _$LoginReqModelToJson(this);
}
