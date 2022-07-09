import 'dart:developer';

import 'package:flutter/material.dart';

class ErrorLoadImage extends StatelessWidget {
  const ErrorLoadImage({Key? key, required this.ex}) : super(key: key);

  final Object ex;

  @override
  Widget build(BuildContext context) {
    log('Fail to load image: ${ex.toString()}');

    return Container(
      padding: const EdgeInsets.all(10),
      color: Colors.amber,
      alignment: Alignment.center,
      child: const Text(
        "Whoops! Fail to load image",
        textAlign: TextAlign.center,
      ),
    );
  }
}
