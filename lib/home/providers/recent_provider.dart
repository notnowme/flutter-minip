import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minip/home/models/board_recent_model.dart';
import 'package:minip/home/repository/recent_repository.dart';

class FreeRecentAsyncDisposeNotifier extends AutoDisposeAsyncNotifier<dynamic> {
  RecentRepository? repo;
  late dynamic resultData;

  @override
  FutureOr build() async {
    repo ??= ref.watch(recentRepositoryProvider);
    return await getFreeRecent();
  }

  getFreeRecent() async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      resultData = await repo!.getFreeRecentLists();
    });
    print(state);
    if (state.hasError) {
      DioException error = state.error as DioException;
      return {
        'ok': false,
        'statusCode': error.response?.statusCode,
      };
    }
    return resultData as RecentBoardModel;
  }
}

class QnaRecentAsyncDisposeNotifier extends AutoDisposeAsyncNotifier<dynamic> {
  RecentRepository? repo;
  late dynamic resultData;

  @override
  FutureOr build() async {
    repo ??= ref.watch(recentRepositoryProvider);
    return await getQnaRecent();
  }

  getQnaRecent() async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      resultData = await repo!.getQnaRecentLists();
    });
    if (state.hasError) {
      DioException error = state.error as DioException;
      return {
        'ok': false,
        'statusCode': error.response?.statusCode,
      };
    }
    return resultData as RecentBoardModel;
  }
}

final freeRecentListAsyncProvider =
    AutoDisposeAsyncNotifierProvider<FreeRecentAsyncDisposeNotifier, dynamic>(
        () {
  return FreeRecentAsyncDisposeNotifier();
});

final qnaRecentListAsyncProvider =
    AutoDisposeAsyncNotifierProvider<QnaRecentAsyncDisposeNotifier, dynamic>(
        () {
  return QnaRecentAsyncDisposeNotifier();
});
