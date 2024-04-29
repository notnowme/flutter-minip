import 'package:json_annotation/json_annotation.dart';

part 'user_detail_model.g.dart';

@JsonSerializable()
class UserDetailModel {
  final bool ok;
  final UserDetailDataModel data;
  final int freeBoardCount, qnaBoardCount, freeCommentCount, qnaCommentCount;

  UserDetailModel({
    required this.ok,
    required this.data,
    required this.freeBoardCount,
    required this.qnaBoardCount,
    required this.freeCommentCount,
    required this.qnaCommentCount,
  });

  factory UserDetailModel.fromJson(Map<String, dynamic> json) =>
      _$UserDetailModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserDetailModelToJson(this);
}

@JsonSerializable()
class UserDetailDataModel {
  final int no;
  final String id, nick, created_at;

  UserDetailDataModel({
    required this.no,
    required this.id,
    required this.nick,
    required this.created_at,
  });

  factory UserDetailDataModel.fromJson(Map<String, dynamic> json) =>
      _$UserDetailDataModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserDetailDataModelToJson(this);
}
