import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minip/user/models/user_detail_model.dart';
import 'package:minip/user/repository/user_repository.dart';

class UserDetailDataAsyncNotifier
    extends AutoDisposeAsyncNotifier<UserDetailModel?> {
  late UserRepositroy repo;
  late UserDetailModel resultData;

  @override
  FutureOr<UserDetailModel?> build() async {
    repo = ref.watch(userRepositoryProvider);
    return await getMeDetail();
  }

  getMeDetail() async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      resultData = await repo.getMeDetail();
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

final userDetailDataAsyncProvider = AutoDisposeAsyncNotifierProvider<
    UserDetailDataAsyncNotifier, UserDetailModel?>(() {
  return UserDetailDataAsyncNotifier();
});
