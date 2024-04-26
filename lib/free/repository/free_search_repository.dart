import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minip/common/const/data.dart';
import 'package:minip/common/providers/dio.dart';
import 'package:minip/free/models/free_list_model.dart';
import 'package:retrofit/retrofit.dart';

part 'free_search_repository.g.dart';

final freeSearchRepository = Provider((ref) {
  final url = '$baseUrl/search';
  final dio = ref.watch(dioProvider);
  final repository = FreeSearchRepository(dio, baseUrl: url);
  return repository;
});

@RestApi()
abstract class FreeSearchRepository {
  factory FreeSearchRepository(Dio dio, {String baseUrl}) =
      _FreeSearchRepository;

  @GET('/')
  Future<FreeListModel> search(
      {@Queries() required Map<String, dynamic> queries});
}
