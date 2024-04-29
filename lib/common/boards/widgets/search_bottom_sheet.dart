import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:minip/common/const/colors.dart';

class SearchBottomSheet {
  static void showSearchBottomSheet(BuildContext context, String routeName) {
    GlobalKey<FormState> pageKey = GlobalKey();
    TextEditingController searchController = TextEditingController();
    const baseBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: inputBorderColodr,
        width: 1,
      ),
    );
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
                            '게시글 검색',
                            style: TextStyle(
                              color: textColor,
                              fontSize: 22,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: 300,
                            child: Form(
                              key: pageKey,
                              child: TextFormField(
                                controller: searchController,
                                autofocus: true,
                                cursorColor: primaryColor,
                                style: const TextStyle(
                                  decorationThickness: 0,
                                ),
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(
                                    10,
                                  ),
                                  filled: true,
                                  fillColor: inputBgColor,
                                  border: baseBorder,
                                  enabledBorder: baseBorder,
                                  focusedBorder: baseBorder.copyWith(
                                    borderSide: baseBorder.borderSide.copyWith(
                                      color: primaryColor,
                                    ),
                                  ),
                                  suffixIcon: InkWell(
                                    onTap: () {
                                      searchController.text = '';
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 14,
                                        horizontal: 14,
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: thirdColor,
                                        ),
                                        child: const Icon(
                                          Icons.close_rounded,
                                          color: secondaryColor,
                                          size: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
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
                                  context.pop();
                                  context.pushNamed(
                                    routeName,
                                    extra: searchController.text,
                                  );
                                  searchController.text = '';
                                },
                                child: const Text(
                                  '검색',
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
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        );
      },
    );
  }
}
