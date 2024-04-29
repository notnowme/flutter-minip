import 'package:flutter_riverpod/flutter_riverpod.dart';

final freePageNumProvider = NotifierProvider<FreePageNumNotifier, int>(() {
  return FreePageNumNotifier();
});

class FreePageNumNotifier extends Notifier<int> {
  @override
  int build() {
    return 1;
  }

  update(int page) {
    state = page;
  }
}
