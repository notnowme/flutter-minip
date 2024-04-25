import 'package:json_annotation/json_annotation.dart';

part 'free_cmt_write_model.g.dart';

@JsonSerializable()
class FreeCommentWriteModel {
  final bool ok;
  final FreeCommentWriteDataModel data;

  FreeCommentWriteModel({
    required this.ok,
    required this.data,
  });

  factory FreeCommentWriteModel.fromJson(Map<String, dynamic> json) =>
      _$FreeCommentWriteModelFromJson(json);
  Map<String, dynamic> toJson() => _$FreeCommentWriteModelToJson(this);
}

@JsonSerializable()
class FreeCommentWriteDataModel {
  final int no, board_no, author_no;
  final String content, created_at, updated_at;
  final FreeCommentWriteAuthorModel author;

  FreeCommentWriteDataModel({
    required this.no,
    required this.board_no,
    required this.author_no,
    required this.content,
    required this.created_at,
    required this.updated_at,
    required this.author,
  });

  factory FreeCommentWriteDataModel.fromJson(Map<String, dynamic> json) =>
      _$FreeCommentWriteDataModelFromJson(json);
  Map<String, dynamic> toJson() => _$FreeCommentWriteDataModelToJson(this);
}

@JsonSerializable()
class FreeCommentWriteAuthorModel {
  final String id, nick;

  FreeCommentWriteAuthorModel({
    required this.id,
    required this.nick,
  });

  factory FreeCommentWriteAuthorModel.fromJson(Map<String, dynamic> json) =>
      _$FreeCommentWriteAuthorModelFromJson(json);
  Map<String, dynamic> toJson() => _$FreeCommentWriteAuthorModelToJson(this);
}
