import 'package:json_annotation/json_annotation.dart';

part 'free_search_model.g.dart';

@JsonSerializable()
class FreeSearchModel {
  final String board, cat, keyword;
  final int page;

  FreeSearchModel({
    required this.board,
    required this.cat,
    required this.keyword,
    required this.page,
  });

  FreeSearchModel copywith({
    String? board,
    String? cat,
    String? keyword,
    int? page,
  }) =>
      FreeSearchModel(
        board: board ?? this.board,
        cat: cat ?? this.cat,
        keyword: keyword ?? this.keyword,
        page: page ?? this.page,
      );

  factory FreeSearchModel.fromJson(Map<String, dynamic> json) =>
      _$FreeSearchModelFromJson(json);
  Map<String, dynamic> toJson() => _$FreeSearchModelToJson(this);
}
