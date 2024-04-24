import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:minip/common/const/colors.dart';
import 'package:minip/common/layouts/default_layout.dart';
import 'package:minip/free/models/free_list_model.dart';
import 'package:minip/free/provider/free_list_provider.dart';
import 'package:minip/free/widgets/free_content_card.dart';
import 'package:minip/free/views/free_write_screen.dart';

class FreeIndexScreen extends ConsumerStatefulWidget {
  const FreeIndexScreen({super.key});

  static const String routeName = 'free';
  static const String routePath = '/free';

  @override
  ConsumerState<FreeIndexScreen> createState() => _FreeIndexScreenState();
}

class _FreeIndexScreenState extends ConsumerState<FreeIndexScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '자유 게시판',
      actions: [
        Padding(
          padding: const EdgeInsets.only(
            right: 20,
          ),
          child: InkWell(
            onTap: () {
              context.pushNamed(FreeWriteScreen.routeName);
            },
            splashColor: Colors.grey[300],
            borderRadius: BorderRadius.circular(50),
            child: const SizedBox(
              width: 32,
              height: 32,
              child: Icon(
                Icons.create_rounded,
                size: 24,
                color: primaryColor,
              ),
            ),
          ),
        )
      ],
      child: ref.watch(freeListAsyncProvider('1')).when(
        data: (data) {
          if (data.ok) {
            return ListView.separated(
              itemCount: data.data.length,
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 0,
                );
              },
              itemBuilder: (context, index) {
                var content = data.data[index];
                return FreeContentCard(
                  data: content,
                );
              },
            );
          } else {
            return const Center(
              child: Text('wrong'),
            );
          }
        },
        error: (error, stackTrace) {
          print(error);
          return const Center(
            child: Text('error'),
          );
        },
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
