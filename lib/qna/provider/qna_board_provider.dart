import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minip/free/models/free_cmt_modify_model.dart';
import 'package:minip/free/models/free_cmt_write_model.dart';
import 'package:minip/free/models/free_modify_model.dart';
import 'package:minip/free/models/free_write_model.dart';
import 'package:minip/qna/repository/qna_cmt_repository.dart';
import 'package:minip/qna/repository/qna_repository.dart';

class QnaBoardAsyncNotifier extends AsyncNotifier<void> {
  late final QnaRepository repo;
  late final QnaCommentRepository repoCmt;
  late FreeWriteModel resultData;
  late Map<String, bool> resultDeletedData;
  late FreeModifyModel resultModifyData;
  late FreeCommentWriteModel resultCommentData;
  late FreeCommentModifyModel resultCommentModifyData;

  @override
  FutureOr<void> build() {
    repo = ref.watch(qnaRepositoryProvider);
    repoCmt = ref.watch(qnaCommentRepositoryProvider);
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

    state = await AsyncValue.guard(
      () async {
        resultCommentData = await repoCmt.writeComment(data: data);
      },
    );

    if (state.hasError) {
      DioException error = state.error as DioException;
      return {
        'ok': false,
        'statusCode': error.response?.statusCode,
      };
    }
    return resultCommentData;
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
}

final qnaBoardAsyncProvider =
    AsyncNotifierProvider<QnaBoardAsyncNotifier, void>(() {
  return QnaBoardAsyncNotifier();
});
