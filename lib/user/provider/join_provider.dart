import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minip/user/models/auth_model.dart';
import 'package:minip/user/models/join_data_model.dart';
import 'package:minip/user/repository/user_repository.dart';

class JoinAsyncNotifier extends AsyncNotifier<AuthModel> {
  late final UserRepository repo;
  late AuthModel resultData;

  @override
  FutureOr<AuthModel> build() {
    repo = ref.watch(userRepositoryProvider);
    return AuthModel(ok: false, message: '');
  }

  checkId(String id) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      return await repo.checkId(data: {'id': id});
    });

    if (state.hasError) {
      DioException error = state.error as DioException;
      return {
        'ok': false,
        'statusCode': error.response?.statusCode,
      };
    }

    return {'ok': true};
  }

  checkNick(String nick) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      return await repo.checkNick(data: {'nick': nick});
    });

    if (state.hasError) {
      DioException error = state.error as DioException;
      return {
        'ok': false,
        'statusCode': error.response?.statusCode,
      };
    }

    return {'ok': true};
  }

  join(JoinDataModel user) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      return await repo.join(data: user.toJson());
    });

    if (state.hasError) {
      DioException error = state.error as DioException;
      return {
        'ok': false,
        'statusCode': error.response?.statusCode,
      };
    }
    return {'ok': true};
  }
}

final joinAsyncProvider =
    AsyncNotifierProvider<JoinAsyncNotifier, AuthModel>(() {
  return JoinAsyncNotifier();
});
