import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minip/free/models/free_list_model.dart';
import 'package:minip/qna/repository/qna_repository.dart';

class QnaListAsyncFamilyNotifier extends FamilyAsyncNotifier<dynamic, int> {
  QnaRepository? repo;
  late dynamic resultData;

  @override
  FutureOr build(int arg) async {
    repo ??= ref.watch(qnaRepositoryProvider);
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

final qnaListAsyncProvider =
    AsyncNotifierProviderFamily<QnaListAsyncFamilyNotifier, dynamic, int>(() {
  return QnaListAsyncFamilyNotifier();
});
