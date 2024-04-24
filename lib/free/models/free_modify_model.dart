import 'package:json_annotation/json_annotation.dart';

part 'free_modify_model.g.dart';

@JsonSerializable()
class FreeModifyModel {
  final bool ok;
  final FreeModifyDataModel data;

  FreeModifyModel({
    required this.ok,
    required this.data,
  });

  factory FreeModifyModel.fromJson(Map<String, dynamic> json) =>
      _$FreeModifyModelFromJson(json);
  Map<String, dynamic> toJson() => _$FreeModifyModelToJson(this);
}

@JsonSerializable()
class FreeModifyDataModel {
  final int no, author_no;
  final String title, content, created_at, updated_at;

  FreeModifyDataModel({
    required this.no,
    required this.author_no,
    required this.title,
    required this.content,
    required this.created_at,
    required this.updated_at,
  });

  factory FreeModifyDataModel.fromJson(Map<String, dynamic> json) =>
      _$FreeModifyDataModelFromJson(json);
  Map<String, dynamic> toJson() => _$FreeModifyDataModelToJson(this);
}
