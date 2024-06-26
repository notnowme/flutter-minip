import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minip/user/models/auth_model.dart';
import 'package:minip/user/models/join_data_model.dart';
import 'package:minip/user/repository/auth_repository.dart';

class JoinAsyncNotifier extends AsyncNotifier<AuthModel> {
  late final AuthRepository repo;
  late AuthModel resultData;

  @override
  FutureOr<AuthModel> build() {
    repo = ref.watch(authRepositoryProvider);
    return AuthModel(ok: false, message: '');
  }

  checkToken() async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      resultData = await repo.checkToken();
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

  checkPassword(String id, String password) async {
    final data = {
      'id': id,
      'password': password,
    };
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      resultData = await repo.checkPassword(data: data);
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

  withdraw() async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      resultData = await repo.withdraw();
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
