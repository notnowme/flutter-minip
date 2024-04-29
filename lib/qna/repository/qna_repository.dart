import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minip/common/const/data.dart';
import 'package:minip/common/providers/dio.dart';
import 'package:minip/free/models/free_list_model.dart';
import 'package:minip/free/models/free_modify_model.dart';
import 'package:minip/free/models/free_one_model.dart';
import 'package:minip/free/models/free_write_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:retrofit/http.dart';

part 'qna_repository.g.dart';

final qnaRepositoryProvider = Provider((ref) {
  final url = '$baseUrl/board/qna';
  final dio = ref.watch(dioProvider);
  final repository = QnaRepository(dio, baseUrl: url);
  return repository;
});

@RestApi()
abstract class QnaRepository {
  factory QnaRepository(Dio dio, {String baseUrl}) = _QnaRepository;

  // 전체 게시글 가져오기
  @GET('/')
  Future<FreeListModel> getLists({@Query('page') required int page});

  // 게시글 작성
  @POST('/')
  @Headers({'accessToken': 'true'})
  Future<FreeWriteModel> writedown(
      {@Body() required Map<String, dynamic> data});

  // 게시글 수정
  @PUT('/{no}')
  @Headers({'accessToken': 'true'})
  Future<FreeModifyModel> modify({
    @Body() required Map<String, dynamic> data,
    @Path() required String no,
  });

  // 게시글 삭제
  @DELETE('/{no}')
  @Headers({'accessToken': 'true'})
  Future<Map<String, bool>> delete({
    @Path() required String no,
  });

  // 특정 게시글 가져오기
  @GET('/{no}')
  Future<FreeOneModel> getOne({@Path() required String no});
}
