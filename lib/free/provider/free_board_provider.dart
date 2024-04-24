import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minip/free/models/free_modify_model.dart';
import 'package:minip/free/models/free_one_model.dart';
import 'package:minip/free/models/free_write_model.dart';
import 'package:minip/free/repository/free_repository.dart';

class FreeBoardAsyncNotifier extends AsyncNotifier<void> {
  late final FreeRepository repo;
  late FreeWriteModel resultData;
  late FreeModifyModel resultModifyData;

  @override
  FutureOr<void> build() {
    repo = ref.watch(freeRepositoryProvider);
  }

  writedown(String title, String content) async {
    final data = {
      'title': title,
      'content': content,
    };
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      resultData = await repo.writedown(data: data);
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

  modify(String title, String content, String no) async {
    final data = {
      'title': title,
      'content': content,
    };

    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      resultModifyData = await repo.modify(data: data, no: no);
    });

    if (state.hasError) {
      DioException error = state.error as DioException;
      return {
        'ok': false,
        'statusCode': error.response?.statusCode,
      };
    }
    return resultModifyData;
  }
}

final freeBoardAsyncProvider =
    AsyncNotifierProvider<FreeBoardAsyncNotifier, void>(() {
  return FreeBoardAsyncNotifier();
});
