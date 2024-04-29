import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minip/free/models/free_write_model.dart';
import 'package:minip/qna/repository/qna_repository.dart';

class QnaBoardAsyncNotifier extends AsyncNotifier<void> {
  late final QnaRepository repo;
  late FreeWriteModel resultData;

  @override
  FutureOr<void> build() {
    repo = ref.watch(qnaRepositoryProvider);
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
}

final qnaBoardAsyncProvider =
    AsyncNotifierProvider<QnaBoardAsyncNotifier, void>(() {
  return QnaBoardAsyncNotifier();
});
