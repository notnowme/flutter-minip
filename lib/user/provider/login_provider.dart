import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minip/user/models/login_req_model.dart';
import 'package:minip/user/models/login_res_model.dart';
import 'package:minip/user/repository/user_repository.dart';

class LoginAsyncNotifier extends AsyncNotifier<LoginResModel> {
  late final UserRepository repo;
  late LoginResModel resultData;

  @override
  FutureOr<LoginResModel> build() {
    repo = ref.watch(userRepositoryProvider);
    return LoginResModel(
      ok: false,
      data: LoginDataModel(
        no: 0,
        id: '',
        nick: '',
        token: '',
      ),
    );
  }

  login(LoginReqModel user) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      resultData = await repo.login(data: user.toJson());
      return resultData;
    });

    if (state.hasError) {
      DioException error = state.error as DioException;
      return {
        'ok': false,
        'statusCode': error.response?.statusCode,
      };
    }
    return resultData;
  }
}

final loginAsyncProvider =
    AsyncNotifierProvider<LoginAsyncNotifier, LoginResModel>(() {
  return LoginAsyncNotifier();
});
