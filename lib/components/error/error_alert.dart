import 'package:flutter/material.dart';
import 'package:medicalarm/components/button/buttons.dart';
import 'package:medicalarm/features/localization/l.dart';
import 'package:url_launcher/url_launcher.dart';

void showErrorAlert(BuildContext? context, Object error) {
  if (context == null) {
    return;
  }
  final String title;
  final String message;
  final String? faqLinkURL;
  if (error is FormatException) {
    title = L.unknownError;
    message = error.message;
    faqLinkURL = null;
  } else if (error is String) {
    title = L.error;
    message = error;
    faqLinkURL = null;
  } else {
    title = L.unexpectedError;
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
        title ?? L.error,
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
          AlertButton(
            text: L.viewFaq,
            onPressed: () async {
              launchUrl(Uri.parse(faq));
            },
          ),
        AlertButton(
          text: L.close,
          onPressed: () async {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
