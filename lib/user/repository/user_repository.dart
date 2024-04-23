import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minip/common/const/data.dart';
import 'package:minip/common/providers/dio.dart';
import 'package:minip/user/models/auth_model.dart';
import 'package:minip/user/models/login_res_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:retrofit/http.dart';

part 'user_repository.g.dart';

final userRepositoryProvider = Provider((ref) {
  final url = '$baseUrl/auth';
  final dio = ref.watch(dioProvider);
  final repository = UserRepository(dio, baseUrl: url);
  return repository;
});

@RestApi()
abstract class UserRepository {
  factory UserRepository(Dio dio, {String baseUrl}) = _UserRepository;

  @POST('/check/id')
  Future<AuthModel> checkId({@Body() required Map<String, dynamic> data});

  @POST('/check/nick')
  Future<AuthModel> checkNick({@Body() required Map<String, dynamic> data});

  @POST('/local/join')
  Future<AuthModel> join({@Body() required Map<String, dynamic> data});

  @POST('/login')
  Future<LoginResModel> login({@Body() required Map<String, dynamic> data});
}
