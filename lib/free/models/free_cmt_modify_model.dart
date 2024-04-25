import 'package:json_annotation/json_annotation.dart';

part 'free_cmt_modify_model.g.dart';

@JsonSerializable()
class FreeCommentModifyModel {
  final bool ok;
  final FreeCommentModifyDataModel data;

  FreeCommentModifyModel({
    required this.ok,
    required this.data,
  });

  factory FreeCommentModifyModel.fromJson(Map<String, dynamic> json) =>
      _$FreeCommentModifyModelFromJson(json);

  Map<String, dynamic> toJson() => _$FreeCommentModifyModelToJson(this);
}

@JsonSerializable()
class FreeCommentModifyDataModel {
  final int no, board_no, author_no;
  final String content, created_at, updated_at;

  FreeCommentModifyDataModel({
    required this.no,
    required this.board_no,
    required this.author_no,
    required this.content,
    required this.created_at,
    required this.updated_at,
  });

  factory FreeCommentModifyDataModel.fromJson(Map<String, dynamic> json) =>
      _$FreeCommentModifyDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$FreeCommentModifyDataModelToJson(this);
}
