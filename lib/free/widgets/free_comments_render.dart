import 'package:flutter/material.dart';
import 'package:minip/common/const/colors.dart';
import 'package:minip/free/models/free_one_model.dart';
import 'package:minip/free/widgets/free_comment_card.dart';

class FreeCommentsList extends StatelessWidget {
  const FreeCommentsList({
    super.key,
    required this.comments,
  });

  final List<FreeOneCommentsModel> comments;
  @override
  Widget build(BuildContext context) {
    final hasComment = comments.isNotEmpty;

    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 20,
          ),
          child: Align(
            alignment: Alignment.topRight,
            child: Icon(
              Icons.edit,
              size: 24,
              color: primaryColor,
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
