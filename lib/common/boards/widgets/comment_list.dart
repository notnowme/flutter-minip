import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:minip/common/boards/widgets/comment_card.dart';
import 'package:minip/common/const/colors.dart';
import 'package:minip/free/models/free_one_model.dart';

class CommentList extends StatelessWidget {
  const CommentList({
    super.key,
    required this.comments,
    required this.boardNo,
    required this.myId,
    required this.routeName,
    required this.commentModifyRouterName,
    required this.deleteComment,
  });

  final List<FreeOneCommentsModel> comments;
  final int boardNo;
  final String? myId;
  final String routeName;
  final String commentModifyRouterName;
  final Function deleteComment;

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
          child: myId == null
              ? Container()
              : Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      context.pushNamed(
                        routeName,
                        pathParameters: {'no': boardNo.toString()},
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
                    child: CommentCard(
                      comment: comment,
                      isAuthorMe: myId == comment.author.id,
                      routeName: routeName,
                      commentModifyRouterName: commentModifyRouterName,
                      deleteComment: deleteComment,
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
