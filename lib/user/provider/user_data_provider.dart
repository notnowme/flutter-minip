import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:minip/common/const/data.dart';
import 'package:minip/common/providers/secure_storage.dart';
import 'package:minip/user/models/user_model.dart';

class UserDataAsyncNotifier extends AutoDisposeAsyncNotifier<UserModel?> {
  late FlutterSecureStorage storage;

  @override
  FutureOr<UserModel?> build() {
    storage = ref.read(secureStorageProvider);
    return getMe();
  }

  getMe() async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(
      () async {
        final users = await Future.wait(
          [
            storage.read(key: STORAGE_USER_NO),
            storage.read(key: STORAGE_ID),
            storage.read(key: STORAGE_NICK),
            storage.read(key: ACCESS_KEY),
          ],
        );
        if (users.isEmpty) {
          return null;
        }
        UserModel user = UserModel(
            no: users[0]!,
            id: users[1]!,
            nick: users[2]!,
            accessToken: users[3]!);
        return user;
      },
    );

    if (state.hasError) {
      return false;
    }
  }
}

final userDataAsyncNotifier =
    AutoDisposeAsyncNotifierProvider<UserDataAsyncNotifier, UserModel?>(() {
  return UserDataAsyncNotifier();
});
