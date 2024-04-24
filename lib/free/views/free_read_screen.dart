import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minip/common/const/colors.dart';
import 'package:minip/common/layouts/default_layout.dart';
import 'package:minip/free/models/free_one_model.dart';
import 'package:minip/free/provider/free_one_provider.dart';
import 'package:minip/free/widgets/free_content_render.dart';

class FreeReadScreen extends ConsumerWidget {
  const FreeReadScreen({
    super.key,
    required this.no,
  });

  static const String routeName = 'freeRead';
  static const String routePath = 'read/:no';
  final String no;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultLayout(
      title: '자유 게시판',
      child: SingleChildScrollView(
        child: Column(
          children: [
            ref.watch(freeOneDisposeAsyncProvider(no)).when(
              data: (data) {
                if (data is FreeOneModel) {
                  final content = data.data;
                  return RenderBoardContent(content: content);
                } else {
                  return const Center(
                    child: Text('no data'),
                  );
                }
              },
              error: (err, errStack) {
                if (err is DioException) {
                  return const Center(
                    child: Text('error'),
                  );
                } else {
                  return Container();
                }
              },
              loading: () {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
