import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:todomaker/components/grounding_data/list.dart';
import 'package:todomaker/entity/grounding_data.dart';
import 'package:todomaker/style/color.dart';

// NOTE: 困ったら Widget を渡すようにするか、リソースごとの個別コンポーネントにする
class HelpAlertLayout extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String detailMarkdown;
  final List<GroundingData> groundings;

  const HelpAlertLayout({
    super.key,
    required this.title,
    required this.subtitle,
    required this.detailMarkdown,
    required this.groundings,
  });

  @override
  Widget build(BuildContext context) {
    final subtitle = this.subtitle;

    final primaryColor = Theme.of(context).colorScheme.primary;

    return AlertDialog(
      title: Column(
        children: [
          Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          if (subtitle != null && subtitle.isNotEmpty) ...[
            Text(subtitle, style: const TextStyle(fontSize: 14, color: TextColor.darkGray)),
            const SizedBox(height: 10),
          ],
        ],
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('詳細', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: primaryColor)),
                  const SizedBox(height: 10),
                  MarkdownBody(data: detailMarkdown),
                ],
              ),
            ),
          ),
          const Divider(
            height: 1,
            color: Colors.black,
          ),
          const SizedBox(height: 10),
          for (final grounding in groundings) GroundingDataList(groundings: [grounding]),
        ],
      ),
      // Default padding is 20;
      contentPadding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 0),
      actionsPadding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('閉じる')),
      ],
    );
  }
}
