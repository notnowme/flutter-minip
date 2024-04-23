import 'package:json_annotation/json_annotation.dart';

part 'join_data_model.g.dart';

@JsonSerializable()
class JoinDataModel {
  final String id, nick, password;

  JoinDataModel({
    required this.id,
    required this.nick,
    required this.password,
  });

  factory JoinDataModel.fromJson(Map<String, dynamic> json) =>
      _$JoinDataModelFromJson(json);
  Map<String, dynamic> toJson() => _$JoinDataModelToJson(this);
}
