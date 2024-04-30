import 'package:flutter_riverpod/flutter_riverpod.dart';

final freePageNumProvider =
    AutoDisposeNotifierProvider<FreePageNumNotifier, int>(() {
  return FreePageNumNotifier();
});

class FreePageNumNotifier extends AutoDisposeNotifier<int> {
  @override
  int build() {
    return 1;
  }

  update(int page) {
    state = page;
  }
}
