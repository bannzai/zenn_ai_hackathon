import 'package:flutter/material.dart';
import 'package:todomaker/entity/grounding_data.dart';
import 'package:todomaker/entity/location.dart';
import 'package:todomaker/entity/todo.dart';
import 'package:todomaker/style/color.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

// NOTE: TaskLocationItemと一緒な見た目
class TodoLocationsRow extends StatelessWidget {
  final Todo todo;
  const TodoLocationsRow({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    final locations = todo.locations;
    final locationsGroundings = todo.locationsGroundings;
    final locationsAITextResponse = todo.locationsAITextResponse;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (locations != null && locations.isNotEmpty) ...[
          for (final location in locations) ...[
            const SizedBox(height: 10),
            TodoLocationRowContent(
              todo: todo,
              location: location,
              locationsAITextResponse: locationsAITextResponse,
              locationGroundings: locationsGroundings ?? [],
            ),
          ],
        ],
        if (locations == null || locations.isEmpty) ...[
          _TodoLocationRowContentEmpty(todo: todo),
        ],
      ],
    );
  }
}

class TodoLocationRowContent extends StatelessWidget {
  final Todo todo;
  final AppLocation location;
  final String? locationsAITextResponse;
  final List<GroundingData> locationGroundings;

  const TodoLocationRowContent({
    super.key,
    required this.todo,
    required this.location,
    required this.locationsAITextResponse,
    required this.locationGroundings,
  });

  @override
  Widget build(BuildContext context) {
    final address = location.address;
    final postalCode = location.postalCode;
    final tel = location.tel;
    final email = location.email;
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    final emailIsValid = emailRegex.hasMatch(email ?? '');
    return DefaultTextStyle(
      style: const TextStyle(fontSize: 12, color: TextColor.black),
      child: Column(
        children: [
          Row(
            children: [
              const Text('🏠 名称: '),
              Expanded(
                child: GestureDetector(
                  onTap: () => _openMap(nameOrAddress: location.name ?? ''),
                  child: Text(location.name ?? '', style: const TextStyle(color: TextColor.link)),
                ),
              ),
            ],
          ),
          if (address != null) ...[
            Row(
              children: [
                const Text('📝 住所: '),
                Expanded(
                  child: GestureDetector(
                    onTap: () => _openMap(nameOrAddress: location.address ?? ''),
                    child: Text(address, style: const TextStyle(color: TextColor.link)),
                  ),
                ),
              ],
            ),
          ],
          if (postalCode != null) ...[
            Row(
              children: [
                const Text('📮 郵便番号: '),
                Text(postalCode),
              ],
            ),
          ],
          if (tel != null) ...[
            Row(
              children: [
                const Text('📞 電話番号: '),
                GestureDetector(
                  onTap: () => _openPhoneApp(tel: tel),
                  child: Text(tel, style: const TextStyle(color: TextColor.link)),
                ),
              ],
            ),
          ],
          if (email != null) ...[
            Row(
              children: [
                const Text('📧 メールアドレス: '),
                Expanded(
                  child: GestureDetector(
                    onTap: () => _openMailApp(mailAddress: email),
                    child: Text(email,
                        style: TextStyle(
                          color: emailIsValid ? TextColor.link : TextColor.black,
                        )),
                  ),
                ),
              ],
            ),
          ],
          if (locationGroundings.isNotEmpty) ...[
            const SizedBox(height: 10),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (locationGroundings.isNotEmpty) ...[
                      const Text('参考URL', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                    ],
                    for (final grounding in locationGroundings) ...[
                      if (grounding.url != null) ...[
                        Link(
                            uri: Uri.parse(grounding.url!),
                            builder: (BuildContext ctx, FollowLink? openLink) {
                              return GestureDetector(
                                onTap: openLink,
                                child: Text(
                                  grounding.title ?? '',
                                  style: const TextStyle(fontSize: 12, color: TextColor.link),
                                ),
                              );
                            }),
                      ],
                    ],
                  ],
                ),
                const Spacer(),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _openMap({required String nameOrAddress}) async {
    // FIXME: xxxlaunchUrl 系統でおそらくencodeされているが、その関係でうまくいかないので旧メソッドを使っている
    final url = 'https://www.google.com/maps/search/?api=1&query=$nameOrAddress';
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url, forceSafariVC: false);
    } else {
      final Error error = ArgumentError('Could not launch $url');
      throw error;
    }
  }

  Future<void> _openPhoneApp({required String tel}) async {
    final telValue = tel.replaceAll(' ', '').replaceAll('-', '');
    final Uri uri = Uri(
      scheme: 'tel',
      path: telValue,
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      final Error error = ArgumentError('Could not launch $uri');
      throw error;
    }
  }

  Future<void> _openMailApp({required String mailAddress}) async {
    final uri = Uri(
      scheme: 'mailto',
      path: mailAddress,
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      final Error error = ArgumentError('Could not launch $uri');
      throw error;
    }
  }
}

class _TodoLocationRowContentEmpty extends StatelessWidget {
  final Todo todo;
  const _TodoLocationRowContentEmpty({required this.todo});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text('このTODOは場所に関する情報はありません'),
      ],
    );
  }
}
