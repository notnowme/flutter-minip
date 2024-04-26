import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minip/free/models/free_list_model.dart';
import 'package:minip/free/repository/free_repository.dart';

class FreeListAsyncFamilyNotifer extends FamilyAsyncNotifier<dynamic, int> {
  FreeRepository? repo;
  // error 처리를 위해 dynamic 사용.
  // 정상적으로 됐을 경우 as로 타입 전환.
  late dynamic resultData;

  @override
  FutureOr<dynamic> build(int arg) async {
    repo ??= ref.watch(freeRepositoryProvider);
    return await getLists(page: arg);
  }

  getLists({int page = 1}) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      resultData = await repo!.getLists(page: page);
      return resultData;
    });

    if (state.hasError) {
      DioException error = state.error as DioException;
      return {
        'ok': false,
        'statusCode': error.response?.statusCode,
      };
    }

    return resultData as FreeListModel;
  }
}

final freeListAsyncProvider =
    AsyncNotifierProviderFamily<FreeListAsyncFamilyNotifer, dynamic, int>(() {
  return FreeListAsyncFamilyNotifer();
});
