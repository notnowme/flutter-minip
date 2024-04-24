import 'package:json_annotation/json_annotation.dart';

part 'free_write_model.g.dart';

@JsonSerializable()
class FreeWriteModel {
  final bool ok;
  final FreeWriteDataModel data;

  FreeWriteModel({
    required this.ok,
    required this.data,
  });

  factory FreeWriteModel.fromJson(Map<String, dynamic> json) =>
      _$FreeWriteModelFromJson(json);
  Map<String, dynamic> toJson() => _$FreeWriteModelToJson(this);
}

@JsonSerializable()
class FreeWriteDataModel {
  final int no, author_no;
  final String title, content, created_at, updated_at;
  final FreeWriteAuthorModel author;

  FreeWriteDataModel({
    required this.no,
    required this.author_no,
    required this.title,
    required this.content,
    required this.created_at,
    required this.updated_at,
    required this.author,
  });

  factory FreeWriteDataModel.fromJson(Map<String, dynamic> json) =>
      _$FreeWriteDataModelFromJson(json);
  Map<String, dynamic> toJson() => _$FreeWriteDataModelToJson(this);
}

@JsonSerializable()
class FreeWriteAuthorModel {
  final int no;
  final String id, nick;

  FreeWriteAuthorModel({
    required this.no,
    required this.id,
    required this.nick,
  });

  factory FreeWriteAuthorModel.fromJson(Map<String, dynamic> json) =>
      _$FreeWriteAuthorModelFromJson(json);
  Map<String, dynamic> toJson() => _$FreeWriteAuthorModelToJson(this);
}
