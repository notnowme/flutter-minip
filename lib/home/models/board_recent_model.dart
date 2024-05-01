import 'package:json_annotation/json_annotation.dart';

part 'board_recent_model.g.dart';

@JsonSerializable()
class RecentBoardModel {
  final bool ok;
  final List<RecentBoardDataModel> data;

  RecentBoardModel({
    required this.ok,
    required this.data,
  });

  factory RecentBoardModel.fromJson(Map<String, dynamic> json) =>
      _$RecentBoardModelFromJson(json);
  Map<String, dynamic> toJson() => _$RecentBoardModelToJson(this);
}

@JsonSerializable()
class RecentBoardDataModel {
  final int no, author_no;
  final String title, content, created_at, updated_at;
  final RecentBoardAuthorModel author;
  final List<RecentBoardCommentModel> comments;

  RecentBoardDataModel({
    required this.no,
    required this.author_no,
    required this.title,
    required this.content,
    required this.created_at,
    required this.updated_at,
    required this.author,
    required this.comments,
  });

  factory RecentBoardDataModel.fromJson(Map<String, dynamic> json) =>
      _$RecentBoardDataModelFromJson(json);
  Map<String, dynamic> toJson() => _$RecentBoardDataModelToJson(this);
}

@JsonSerializable()
class RecentBoardAuthorModel {
  final String id, nick;

  RecentBoardAuthorModel({
    required this.id,
    required this.nick,
  });

  factory RecentBoardAuthorModel.fromJson(Map<String, dynamic> json) =>
      _$RecentBoardAuthorModelFromJson(json);
  Map<String, dynamic> toJson() => _$RecentBoardAuthorModelToJson(this);
}

@JsonSerializable()
class RecentBoardCommentModel {
  final int author_no;

  RecentBoardCommentModel({
    required this.author_no,
  });

  factory RecentBoardCommentModel.fromJson(Map<String, dynamic> json) =>
      _$RecentBoardCommentModelFromJson(json);
  Map<String, dynamic> toJson() => _$RecentBoardCommentModelToJson(this);
}
