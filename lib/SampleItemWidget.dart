import 'package:baitap2004/SampleItem.dart';
import 'package:flutter/material.dart';

class SampleItemWidget extends StatelessWidget {
  final SampleItem item;
  final VoidCallback? onTap;

  const SampleItemWidget({Key? key, required this.item, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String?>(
      valueListenable: item.name,
      builder: (context, name, child) {
        debugPrint(item.id);
        return ListTile(
          title: Text(name!),
          subtitle: Text(item.id),
          leading: const CircleAvatar(
            foregroundImage: AssetImage('assets/image/flutter_logo.png'),
          ),
          onTap: onTap,
          trailing: const Icon(Icons.keyboard_arrow_right),
        );
      },
    );
  }
}
