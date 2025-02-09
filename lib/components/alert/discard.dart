import 'package:flutter/material.dart';
import 'package:todomaker/style/color.dart';

class DiscardDialog extends StatelessWidget {
  final String title;
  final Widget message;
  final List<Widget> actions;

  const DiscardDialog({
    super.key,
    required this.title,
    required this.message,
    required this.actions,
  });
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Icon(Icons.warning, color: TextColor.danger),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (title.isNotEmpty) ...[
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 15,
            ),
          ],
          message,
        ],
      ),
      actions: actions,
    );
  }
}

void showDiscardDialog(
  BuildContext context, {
  required String title,
  required String message,
  required List<Widget> actions,
}) {
  showDialog(
    context: context,
    builder: (context) => DiscardDialog(
      title: title,
      message: Text(
        message,
        style: const TextStyle(
          fontWeight: FontWeight.w300,
          fontSize: 14,
        ),
      ),
      actions: actions,
    ),
  );
}
