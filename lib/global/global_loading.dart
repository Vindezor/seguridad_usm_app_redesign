import 'package:flutter/material.dart';

class GlobalLoading extends StatefulWidget {
  const GlobalLoading({super.key});

  @override
  State<GlobalLoading> createState() => _GlobalLoadingState();
}

class _GlobalLoadingState extends State<GlobalLoading> with SingleTickerProviderStateMixin{
 late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _animationController.repeat(reverse: true);

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FadeTransition(
        opacity: _animationController,
        child: Image.asset(
          "assets/usm-logo.png",
          height: 50,
        )
      ),
    );
  }
}

void globalLoading(BuildContext context){
  showDialog(
    barrierColor: Colors.white54,
    barrierDismissible: false,
    context: context,
    builder: (_) => const PopScope(
      canPop: false,
      child: GlobalLoading(),
    )
  );
}