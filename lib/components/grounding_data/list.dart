import 'package:flutter/material.dart';
import 'package:todomaker/entity/grounding_data.dart';

import 'package:url_launcher/link.dart';

class GroundingDataList extends StatelessWidget {
  final List<GroundingData> groundings;
  const GroundingDataList({super.key, required this.groundings});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('出典', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        for (final grounding in groundings) ...[
          GroundingDataRow(grounding: grounding),
        ],
      ],
    );
  }
}

class GroundingDataRow extends StatelessWidget {
  final GroundingData grounding;
  const GroundingDataRow({super.key, required this.grounding});

  @override
  Widget build(BuildContext context) {
    final title = grounding.title;
    final url = grounding.url;
    if (title == null || url == null) {
      return const SizedBox.shrink();
    }
    return Link(
      uri: Uri.parse(url),
      builder: (BuildContext ctx, FollowLink? openLink) {
        return TextButton(
          onPressed: openLink,
          style: ButtonStyle(
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: 2, vertical: 0)),
          ),
          child: Text(
            title,
            style: const TextStyle(fontSize: 12),
          ),
        );
      },
    );
  }
}
