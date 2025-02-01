import 'package:flutter/material.dart';
import 'package:todomaker/components/loading/loading.dart';

class OKDialog extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;
  final Future<void> Function()? ok;

  const OKDialog({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
    required this.ok,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Icon(
        icon,
        color: Theme.of(context).primaryColor,
      ),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (title.isNotEmpty) ...[
            Text(title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                )),
            const SizedBox(
              height: 15,
            ),
          ],
          Text(message,
              style: const TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 14,
              )),
        ],
      ),
      actions: <Widget>[
        LoadingAction(
          action: () async {
            final ok = this.ok;
            if (ok != null) {
              ok();
            } else {
              Navigator.of(context).pop();
            }
          },
          builder: (action) => TextButton(
            onPressed: action,
            child: const Text('OK'),
          ),
        ),
      ],
    );
  }
}

Future<void> showOKDialog(
  BuildContext context, {
  required IconData icon,
  required String title,
  required String message,
  Future<void> Function()? ok,
}) async {
  return showDialog(
    context: context,
    builder: (context) => OKDialog(
      icon: icon,
      title: title,
      message: message,
      ok: ok,
    ),
  );
}
