import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minip/common/const/data.dart';
import 'package:minip/common/providers/dio.dart';
import 'package:minip/free/models/free_list_model.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

part 'qna_search_repository.g.dart';

final qnaSearchRepository = Provider((ref) {
  final url = '$baseUrl/';
  final dio = ref.watch(dioProvider);
  final repository = QnaSearchRepository(dio, baseUrl: url);
  return repository;
});

@RestApi()
abstract class QnaSearchRepository {
  factory QnaSearchRepository(Dio dio, {String baseUrl}) = _QnaSearchRepository;

  @GET('search')
  Future<FreeListModel> search(
      {@Queries() required Map<String, dynamic> queries});
}
