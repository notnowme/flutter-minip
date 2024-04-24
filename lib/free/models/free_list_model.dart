import 'package:json_annotation/json_annotation.dart';

part 'free_list_model.g.dart';

@JsonSerializable()
class FreeListModel {
  final bool ok;
  final List<FreeListDataModel> data;
  final int boardsCount, allCounts;

  FreeListModel({
    required this.ok,
    required this.data,
    required this.boardsCount,
    required this.allCounts,
  });

  factory FreeListModel.fromJson(Map<String, dynamic> json) =>
      _$FreeListModelFromJson(json);
  Map<String, dynamic> toJson() => _$FreeListModelToJson(this);
}

@JsonSerializable()
class FreeListDataModel {
  final int no, author_no;
  final String title, content, created_at, updated_at;
  final FreeListDataAuthorModel author;
  final List<FreeListCommentsModel> comments;

  FreeListDataModel({
    required this.no,
    required this.author_no,
    required this.title,
    required this.content,
    required this.created_at,
    required this.updated_at,
    required this.author,
    required this.comments,
  });

  factory FreeListDataModel.fromJson(Map<String, dynamic> json) =>
      _$FreeListDataModelFromJson(json);
  Map<String, dynamic> toJson() => _$FreeListDataModelToJson(this);
}

@JsonSerializable()
class FreeListDataAuthorModel {
  final String id, nick;

  FreeListDataAuthorModel({
    required this.id,
    required this.nick,
  });

  factory FreeListDataAuthorModel.fromJson(Map<String, dynamic> json) =>
      _$FreeListDataAuthorModelFromJson(json);
  Map<String, dynamic> toJson() => _$FreeListDataAuthorModelToJson(this);
}

@JsonSerializable()
class FreeListCommentsModel {
  final int author_no;

  FreeListCommentsModel({
    required this.author_no,
  });

  factory FreeListCommentsModel.fromJson(Map<String, dynamic> json) =>
      _$FreeListCommentsModelFromJson(json);
  Map<String, dynamic> toJson() => _$FreeListCommentsModelToJson(this);
}
