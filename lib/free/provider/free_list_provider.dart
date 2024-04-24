import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minip/free/models/free_list_model.dart';
import 'package:minip/free/repository/free_repository.dart';

class FreeListAsyncFamilyNotifer
    extends FamilyAsyncNotifier<FreeListModel, String> {
  FreeRepository? repo;
  late FreeListModel resultData;

  @override
  FutureOr<FreeListModel> build(String arg) async {
    repo ??= ref.watch(freeRepositoryProvider);
    return await getLists(page: arg);
  }

  getLists({String page = '1'}) async {
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

    return resultData;
  }
}

final freeListAsyncProvider = AsyncNotifierProviderFamily<
    FreeListAsyncFamilyNotifer, FreeListModel, String>(() {
  return FreeListAsyncFamilyNotifer();
});
