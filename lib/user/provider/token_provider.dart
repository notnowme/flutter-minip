import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minip/user/models/auth_model.dart';
import 'package:minip/user/repository/auth_repository.dart';

class TokenAsyncNotifier extends AsyncNotifier<AuthModel> {
  late final AuthRepository repo;
  late AuthModel resultData;

  @override
  FutureOr<AuthModel> build() async {
    repo = ref.watch(authRepositoryProvider);
    return await checkToken();
  }

  checkToken() async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      resultData = await repo.checkToken();
      return resultData;
    });

    if (state.hasError) {
      DioException error = state.error as DioException;
      return AuthModel(
          ok: false, message: error.response!.statusCode.toString());
    }

    return resultData;
  }
}

final tokenAsyncProvider =
    AsyncNotifierProvider<TokenAsyncNotifier, AuthModel>(() {
  return TokenAsyncNotifier();
});
