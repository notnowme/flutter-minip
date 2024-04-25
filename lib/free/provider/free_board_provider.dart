import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minip/free/models/free_cmt_modify_model.dart';
import 'package:minip/free/models/free_cmt_write_model.dart';
import 'package:minip/free/models/free_modify_model.dart';
import 'package:minip/free/models/free_write_model.dart';
import 'package:minip/free/repository/free_cmt_repository.dart';
import 'package:minip/free/repository/free_repository.dart';

class FreeBoardAsyncNotifier extends AsyncNotifier<void> {
  late final FreeRepository repo;
  late final FreeCommentRepository repoCmt;
  late FreeWriteModel resultData;
  late FreeModifyModel resultModifyData;
  late FreeCommentWriteModel resultCommentData;
  late FreeCommentModifyModel resultCommentModifyData;
  late Map<String, bool> resultDeletedData;

  @override
  FutureOr<void> build() {
    repo = ref.watch(freeRepositoryProvider);
    repoCmt = ref.watch(freeCommentRepositoryProvider);
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

  writeComment(int boardNo, String content) async {
    final data = {
      'boardNo': boardNo,
      'content': content,
    };

    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      resultCommentData = await repoCmt.writeComment(data: data);
    });

    if (state.hasError) {
      DioException error = state.error as DioException;
      return {
        'ok': false,
        'statusCode': error.response?.statusCode,
      };
    }
    return resultCommentData;
  }

  modifyComment(String cmtNo, String content) async {
    final data = {
      'content': content,
    };

    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      resultCommentModifyData =
          await repoCmt.modifyComment(data: data, no: cmtNo);
    });

    if (state.hasError) {
      DioException error = state.error as DioException;
      return {
        'ok': false,
        'statusCode': error.response?.statusCode,
      };
    }
    return resultCommentModifyData;
  }

  delete(String no) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      resultDeletedData = await repo.delete(no: no);
    });

    if (state.hasError) {
      DioException error = state.error as DioException;
      return {
        'ok': false,
        'statusCode': error.response?.statusCode,
      };
    }
    return resultDeletedData;
  }

  deleteComment(String no) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      resultDeletedData = await repoCmt.deleteComment(no: no);
    });

    if (state.hasError) {
      DioException error = state.error as DioException;
      return {
        'ok': false,
        'statusCode': error.response?.statusCode,
      };
    }
    return resultDeletedData;
  }
}

final freeBoardAsyncProvider =
    AsyncNotifierProvider<FreeBoardAsyncNotifier, void>(() {
  return FreeBoardAsyncNotifier();
});
