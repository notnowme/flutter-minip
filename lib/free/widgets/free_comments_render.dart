import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:minip/common/const/colors.dart';
import 'package:minip/free/models/free_one_model.dart';
import 'package:minip/free/views/free_cmt_write.dart';
import 'package:minip/free/widgets/free_comment_card.dart';

class FreeCommentsList extends StatelessWidget {
  const FreeCommentsList({
    super.key,
    required this.comments,
    required this.boardNo,
    required this.myId,
  });

  final List<FreeOneCommentsModel> comments;
  final int boardNo;
  final String? myId;
  @override
  Widget build(BuildContext context) {
    final hasComment = comments.isNotEmpty;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 20,
          ),
          child: Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () {
                // 댓글 작성 이동
                // 글 번호 받아가지고 와야 댈 듯...
                context.pushNamed(
                  FreeCommentWriteScreen.routeName,
                  pathParameters: {'no': '1'},
                  extra: boardNo,
                );
              },
              child: const Icon(
                Icons.edit,
                size: 24,
                color: primaryColor,
              ),
            ),
          ),
        ),
        hasComment
            ? ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: comments.length,
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 0,
                  );
                },
                itemBuilder: (context, index) {
                  var comment = comments[index];
                  return Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 1,
                          color: thirdColor,
                        ),
                      ),
                    ),
                    child: FreeCommentCard(
                      comment: comment,
                      isAuthorMe: myId == comment.author.id,
                    ),
                  );
                },
              )
            : const Column(
                children: [
                  Icon(
                    Icons.cancel_presentation_rounded,
                    size: 92,
                    color: thirdColor,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '작성된 댓글이 없어요',
                    style: TextStyle(
                      color: secondaryColor,
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
      ],
    );
  }
}
