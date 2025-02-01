import 'package:flutter/material.dart';
import 'package:todomaker/components/loading/loading.dart';
import 'package:url_launcher/url_launcher.dart';

void showErrorAlert(BuildContext? context, Object error) {
  if (context == null) {
    return;
  }
  final String title;
  final String message;
  final String? faqLinkURL;
  if (error is FormatException) {
    title = '不明なエラーです';
    message = error.message;
    faqLinkURL = null;
  } else if (error is String) {
    title = 'エラーが発生しました';
    message = error;
    faqLinkURL = null;
  } else {
    title = '予期せぬエラーが発生しました';
    message = error.toString();
    faqLinkURL = null;
  }
  showDialog(
    context: context,
    builder: (_) {
      return ErrorAlert(
        title: title,
        errorMessage: message,
        faqLinkURL: faqLinkURL,
      );
    },
  );
}

class ErrorAlert extends StatelessWidget {
  final String? title;
  final String errorMessage;
  final String? faqLinkURL;

  const ErrorAlert({super.key, this.title, this.faqLinkURL, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    final faq = faqLinkURL;
    return AlertDialog(
      title: Text(
        title ?? 'エラーが発生しました',
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: Colors.black,
        ),
      ),
      content: Text(errorMessage,
          style: const TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 14,
            color: Colors.black,
          )),
      actions: <Widget>[
        if (faq != null)
          LoadingAction(
            action: () async {
              launchUrl(Uri.parse(faq));
            },
            builder: (action) => TextButton(
              onPressed: action,
              child: const Text('FAQを見る'),
            ),
          ),
        LoadingAction(
          action: () async {
            Navigator.of(context).pop();
          },
          builder: (action) => TextButton(
            onPressed: action,
            child: const Text('閉じる'),
          ),
        ),
      ],
    );
  }
}
