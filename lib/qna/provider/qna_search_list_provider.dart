import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minip/free/models/free_list_model.dart';
import 'package:minip/free/models/free_search_model.dart';
import 'package:minip/qna/repository/qna_search_repository.dart';

class QnaSearchListAsyncFamilyNotifier
    extends FamilyAsyncNotifier<dynamic, FreeSearchModel> {
  QnaSearchRepository? repo;
  late FreeSearchModel formData;
  late dynamic resultData;

  @override
  FutureOr build(FreeSearchModel arg) async {
    repo ??= ref.watch(qnaSearchRepository);
    return await getLists(arg);
  }

  getLists(FreeSearchModel form) async {
    final queries = <String, dynamic>{
      'board': form.board,
      'cat': form.cat,
      'key': form.keyword,
      'page': form.page,
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

final qnaSearchListAsyncProvider = AsyncNotifierProviderFamily<
    QnaSearchListAsyncFamilyNotifier, dynamic, FreeSearchModel>(() {
  return QnaSearchListAsyncFamilyNotifier();
});
