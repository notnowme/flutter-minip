import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minip/free/models/free_one_model.dart';
import 'package:minip/free/repository/free_repository.dart';

class FreeOneDisposeAsyncNotifier
    extends AutoDisposeFamilyAsyncNotifier<FreeOneModel?, String> {
  FreeRepository? repo;
  FreeOneModel? resultData;

  @override
  FutureOr<FreeOneModel?> build(String arg) {
    repo ??= ref.watch(freeRepositoryProvider);
    return getOne(arg);
  }

  getOne(String no) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      resultData = await repo!.getOne(no: no);
      return resultData;
    });

    if (state.hasError) {
      if (state.error is DioException) {
        DioException error = state.error as DioException;
        return {
          'ok': false,
          'statusCode': error.response?.statusCode,
        };
      } else {
        return null;
      }
    }
    return resultData;
  }
}

final freeOneDisposeAsyncProvider = AutoDisposeAsyncNotifierProviderFamily<
    FreeOneDisposeAsyncNotifier, FreeOneModel?, String>(() {
  return FreeOneDisposeAsyncNotifier();
});
