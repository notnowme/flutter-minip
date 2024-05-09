import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minip/common/const/data.dart';
import 'package:minip/common/providers/dio.dart';
import 'package:minip/home/models/board_recent_model.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

part 'recent_repository.g.dart';

final recentRepositoryProvider = Provider((ref) {
  final url = '$baseUrl/recent';
  final dio = ref.watch(dioProvider);
  final repository = RecentRepository(dio, baseUrl: url);
  return repository;
});

@RestApi()
abstract class RecentRepository {
  factory RecentRepository(Dio dio, {String baseUrl}) = _RecentRepository;

  @GET('/free')
  Future<RecentBoardModel> getFreeRecentLists();

  @GET('/qna')
  Future<RecentBoardModel> getQnaRecentLists();
}
