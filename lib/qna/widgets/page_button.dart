import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:minip/common/const/colors.dart';
import 'package:minip/common/hooks/validation.dart';
import 'package:minip/common/widgets/custom_text_formField.dart';
import 'package:minip/qna/provider/qna_page_num_provider.dart';

class PageMoveButton extends ConsumerWidget {
  const PageMoveButton({super.key, required this.provider});

  final AsyncNotifierProviderFamily provider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: inputBgColor,
            side: const BorderSide(
              width: 1,
              color: thirdColor,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                5,
              ),
            ),
          ),
          onPressed: () {
            showPageBottomSheet(context, ref);
          },
          child: const Text(
            '페이지 이동',
            style: TextStyle(
              color: textColor,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  void showPageBottomSheet(BuildContext context, WidgetRef ref) {
    final page = ref.watch(qnaPageNumProvider);
    TextEditingController pageNumController = TextEditingController();
    GlobalKey<FormState> pageKey = GlobalKey();
    pageNumController.text = page.toString();
    showModalBottomSheet(
      useRootNavigator: true,
      isScrollControlled: true,
      clipBehavior: Clip.hardEdge,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
            27,
          ),
        ),
      ),
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.all(
                  5,
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          onPressed: () {
                            context.pop();
                          },
                          icon: const Icon(
                            Icons.close,
                            color: textColor,
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          const Text(
                            '페이지 이동',
                            style: TextStyle(
                              color: textColor,
                              fontSize: 22,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: 40,
                            child: Form(
                              key: pageKey,
                              child: CustomTextFormField(
                                controller: pageNumController,
                                isAutoFocus: true,
                                textType: TextInputType.number,
                                onChanged: (value) {},
                                validator: (value) {
                                  return Validation.validatePageMove(value);
                                },
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  context.pop();
                                },
                                child: const Text(
                                  '취소',
                                  style: TextStyle(
                                    color: secondaryColor,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 100,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  if (pageKey.currentState!.validate()) {
                                    ref
                                        .read(qnaPageNumProvider.notifier)
                                        .update(
                                            int.parse(pageNumController.text));
                                    ref.refresh(provider(page));
                                    context.pop();
                                  }
                                },
                                child: const Text(
                                  '이동',
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
