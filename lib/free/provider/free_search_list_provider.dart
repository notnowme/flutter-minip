import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minip/free/models/free_list_model.dart';
import 'package:minip/free/repository/free_search_repository.dart';

class FreeSearchListAsyncFamilyNotifier
    extends FamilyAsyncNotifier<dynamic, Map<String, dynamic>> {
  FreeSearchRepository? repo;

  late dynamic resultData;

  @override
  FutureOr build(Map<String, dynamic> arg) {
    repo ??= ref.watch(freeSearchRepository);
  }

  getLists(String board, String cat, String keyword, int page) async {
    final queries = <String, dynamic>{
      r'board': board,
      r'cat': cat,
      r'keyword': keyword,
      r'page': page,
    };

    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      resultData = await repo!.search(queries: queries);
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

final freeSearchListAsyncProvider = AsyncNotifierProviderFamily<
    FreeSearchListAsyncFamilyNotifier, dynamic, Map<String, dynamic>>(() {
  return FreeSearchListAsyncFamilyNotifier();
});
