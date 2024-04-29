import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minip/common/const/data.dart';
import 'package:minip/common/providers/dio.dart';
import 'package:minip/user/models/user_detail_model.dart';
import 'package:minip/user/models/user_nick_modify_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:retrofit/http.dart';

part 'user_repository.g.dart';

final userRepositoryProvider = Provider((ref) {
  final url = '$baseUrl/users';
  final dio = ref.watch(dioProvider);
  final repository = UserRepositroy(dio, baseUrl: url);
  return repository;
});

@RestApi()
abstract class UserRepositroy {
  factory UserRepositroy(Dio dio, {String baseUrl}) = _UserRepositroy;

  @POST('/')
  @Headers({'accessToken': 'true'})
  Future<UserDetailModel> getMeDetail();

  @PATCH('/')
  @Headers({'accessToken': 'true'})
  Future<UserNickModifyModel> changeNick(
      {@Body() required Map<String, dynamic> data});
}
