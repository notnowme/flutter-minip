import 'package:flutter_riverpod/flutter_riverpod.dart';

final freeSearchPageNumProvider =
    AutoDisposeNotifierProvider<FreeSearchPageNumNotifier, int>(() {
  return FreeSearchPageNumNotifier();
});

class FreeSearchPageNumNotifier extends AutoDisposeNotifier<int> {
  @override
  int build() {
    return 1;
  }

  update(int page) {
    state = page;
  }
}
