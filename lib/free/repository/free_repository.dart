import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minip/common/const/data.dart';
import 'package:minip/common/providers/dio.dart';
import 'package:minip/free/models/free_list_model.dart';
import 'package:minip/free/models/free_one_model.dart';
import 'package:minip/free/models/free_write_model.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

part 'free_repository.g.dart';

final freeRepositoryProvider = Provider((ref) {
  final url = '$baseUrl/board/free';
  final dio = ref.watch(dioProvider);
  final repository = FreeRepository(dio, baseUrl: url);
  return repository;
});

@RestApi()
abstract class FreeRepository {
  factory FreeRepository(Dio dio, {String baseUrl}) = _FreeRepository;

  // 전체 게시글 가져오기
  @GET('/')
  Future<FreeListModel> getLists({@Query('page') required String page});

  // 게시글 작성
  @POST('/')
  @Headers({'accessToken': 'true'})
  Future<FreeWriteModel> writedown(
      {@Body() required Map<String, dynamic> data});

  // 게시글 수정
  @PUT('/{no}')
  @Headers({'accessToken': 'true'})
  Future<FreeWriteModel> modify({
    @Body() required Map<String, dynamic> data,
    @Path() required String no,
  });

  // 특정 게시글 가져오기
  @GET('/{no}')
  Future<FreeOneModel> getOne({@Path() required String no});
}
