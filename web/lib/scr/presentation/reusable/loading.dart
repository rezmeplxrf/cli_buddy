import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class DefaultLoadingWidget extends StatelessWidget {
  const DefaultLoadingWidget(this.size, {super.key});
  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: LoadingAnimationWidget.staggeredDotsWave(
          color: Colors.indigo,
          size: size,
        ),
      ),
    );
  }
}
