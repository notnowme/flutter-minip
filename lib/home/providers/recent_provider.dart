import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minip/home/repository/recent_repository.dart';

class FreeRecentAsyncDisposeNotifier extends AutoDisposeAsyncNotifier<dynamic> {
  RecentRepository? repo;
  late dynamic resultData;

  @override
  FutureOr build() async {
    repo ??= ref.watch(recentRepositoryProvider);
  }

  getFreeRecent() async {}
}

class QnaRecentAsyncDisposeNotifier extends AutoDisposeAsyncNotifier<dynamic> {
  RecentRepository? repo;
  late dynamic resultData;

  @override
  FutureOr build() async {
    repo ??= ref.watch(recentRepositoryProvider);
  }

  getQnaRecent() async {}
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
