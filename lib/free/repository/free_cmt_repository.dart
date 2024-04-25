import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minip/common/const/data.dart';
import 'package:minip/common/providers/dio.dart';
import 'package:minip/free/models/free_cmt_modify_model.dart';
import 'package:minip/free/models/free_cmt_write_model.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

part 'free_cmt_repository.g.dart';

final freeCommentRepositoryProvider = Provider((ref) {
  final url = '$baseUrl/comment/free';
  final dio = ref.watch(dioProvider);
  final repository = FreeCommentRepository(dio, baseUrl: url);
  return repository;
});

@RestApi()
abstract class FreeCommentRepository {
  factory FreeCommentRepository(Dio dio, {String baseUrl}) =
      _FreeCommentRepository;

  @POST('/')
  @Headers({'accessToken': 'true'})
  Future<FreeCommentWriteModel> writeComment(
      {@Body() required Map<String, dynamic> data});

  @PATCH('/{no}')
  @Headers({'accessToken': 'true'})
  Future<FreeCommentModifyModel> modifyComment(
      {@Body() required Map<String, dynamic> data, @Path() required String no});

  @DELETE('/{no}')
  @Headers({'accessToken': 'true'})
  Future<Map<String, bool>> deleteComment({
    @Path() required String no,
  });
}
