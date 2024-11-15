import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/core/utils/colors_manager.dart';

class MyDialog {
  static void showLoading(context, {String? text, bool isDismissible = false}) {
    showDialog(
      barrierDismissible: isDismissible,
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(text ?? ''),
              const CircularProgressIndicator(color: ColorsManager.blue),
            ],
          ),
        );
      },
    );
  }

  static void hide(context) {
    Navigator.pop(context);
  }

  static void showMessage(context,
      {String? title,
      String? body,
      String? posActionTitle,
      VoidCallback? posAction,
      String? negActionTitle,
      VoidCallback? negAction}) {
    showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: title != null ? Text(title) : null,
          content: body != null ? Text(body) : null,
          actions: [
            if (posActionTitle != null)
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                  posAction?.call();
                },
                child: Text(posActionTitle),
              ),
            if (negActionTitle != null)
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                  negAction?.call();
                },
                child: Text(negActionTitle),
              ),
          ],
        );
      },
    );
  }
}
