import 'package:json_annotation/json_annotation.dart';

part 'free_one_model.g.dart';

@JsonSerializable()
class FreeOneModel {
  final bool ok;
  final FreeOneDataModel data;

  FreeOneModel({
    required this.ok,
    required this.data,
  });

  factory FreeOneModel.fromJson(Map<String, dynamic> json) =>
      _$FreeOneModelFromJson(json);
  Map<String, dynamic> toJson() => _$FreeOneModelToJson(this);
}

@JsonSerializable()
class FreeOneDataModel {
  final int no, author_no;
  final String title, content, created_at, updated_at;
  final FreeOneAuthorModel author;
  final List<FreeOneCommentsModel> comments;

  FreeOneDataModel({
    required this.no,
    required this.author_no,
    required this.title,
    required this.content,
    required this.created_at,
    required this.updated_at,
    required this.author,
    required this.comments,
  });

  factory FreeOneDataModel.fromJson(Map<String, dynamic> json) =>
      _$FreeOneDataModelFromJson(json);
  Map<String, dynamic> toJson() => _$FreeOneDataModelToJson(this);
}

@JsonSerializable()
class FreeOneAuthorModel {
  final String id, nick;

  FreeOneAuthorModel({
    required this.id,
    required this.nick,
  });

  factory FreeOneAuthorModel.fromJson(Map<String, dynamic> json) =>
      _$FreeOneAuthorModelFromJson(json);
  Map<String, dynamic> toJson() => _$FreeOneAuthorModelToJson(this);
}

@JsonSerializable()
class FreeOneCommentsModel {
  final int no;
  final String content, created_at, updated_at;
  final FreeOneAuthorModel author;

  FreeOneCommentsModel({
    required this.no,
    required this.content,
    required this.created_at,
    required this.updated_at,
    required this.author,
  });

  factory FreeOneCommentsModel.fromJson(Map<String, dynamic> json) =>
      _$FreeOneCommentsModelFromJson(json);
  Map<String, dynamic> toJson() => _$FreeOneCommentsModelToJson(this);
}
