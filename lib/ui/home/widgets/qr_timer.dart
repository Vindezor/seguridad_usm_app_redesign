import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_design/ui/home/home_controller.dart';

class QrTimer extends ConsumerWidget {
  const QrTimer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(homeController);
    return Text(
      controller.formatDuration(controller.currentDuration!),
      style: const TextStyle(
        color: Color(0xFF3874c0),
        fontSize: 16,
        fontWeight: FontWeight.bold
      ),
    );
  }
}