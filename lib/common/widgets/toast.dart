import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:minip/common/const/colors.dart';

sealed class ItemType {
  final Icon icon;

  ItemType(this.icon);

  factory ItemType.error() => ErrorType(
        const Icon(
          Icons.close_rounded,
          color: errorColor,
        ),
      );
  factory ItemType.success() => SuccessType(
        const Icon(
          Icons.check_rounded,
          color: successColor,
        ),
      );
  factory ItemType.info() => InfoType(
        const Icon(
          Icons.info_outline,
          color: primaryColor,
        ),
      );
}

class ErrorType extends ItemType {
  ErrorType(super.icon);
}

class SuccessType extends ItemType {
  SuccessType(super.icon);
}

class InfoType extends ItemType {
  InfoType(super.icon);
}

class ToastMessage {
  static void showToast(BuildContext context, String type, String text) {
    late Icon icon;

    switch (type) {
      case 'error':
        icon = ItemType.error().icon;
      case 'success':
        icon = ItemType.success().icon;
      case 'info':
        icon = ItemType.info().icon;
    }

    final fToast = FToast();
    fToast.init(context);
    Widget toast = Container(
      width: MediaQuery.of(context).size.width - 40,
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          10,
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          icon,
          const SizedBox(
            width: 4,
          ),
          Text(
            text,
            style: const TextStyle(
              color: textColor,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
    if (context.mounted) {
      fToast.showToast(
        child: toast,
        toastDuration: const Duration(milliseconds: 1000),
        gravity: ToastGravity.CENTER,
        // positionedToastBuilder: (context, child) {
        //   return Stack(
        //     alignment: Alignment.center,
        //     children: [
        //       Positioned(
        //         bottom: 370,
        //         child: child,
        //       ),
        //     ],
        //   );
        // },
      );
    }
  }
}
