import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minip/user/models/user_nick_modify_model.dart';
import 'package:minip/user/repository/user_repository.dart';

class UserAsyncNotifier extends AsyncNotifier<UserNickModifyModel> {
  late final UserRepositroy repo;
  late UserNickModifyModel resultData;

  @override
  FutureOr<UserNickModifyModel> build() async {
    repo = ref.watch(userRepositoryProvider);
    resultData = UserNickModifyModel(
      ok: false,
      data: NickModifyResDataModel(no: -1, id: '', nick: ''),
    );
    return UserNickModifyModel(
      ok: false,
      data: NickModifyResDataModel(
        no: -1,
        id: '',
        nick: '',
      ),
    );
  }

  changeNick(String nick) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      resultData = await repo.changeNick(data: {'nick': nick});
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

final userAsyncProvider =
    AsyncNotifierProvider<UserAsyncNotifier, UserNickModifyModel>(() {
  return UserAsyncNotifier();
});
