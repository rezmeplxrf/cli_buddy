import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

import 'package:flutter/material.dart';

class DefaultErrorWidget extends StatelessWidget {
  const DefaultErrorWidget(
      {this.retry, super.key, this.stackTrace, this.error});
  final StackTrace? stackTrace;
  final String? error;
  final Function? retry;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text(error ?? 'Something went wrong',
              style: const TextStyle(
                fontSize: 12,
              )),
          if (stackTrace != null)
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ExpansionTile(
                  title: const Text('Stack Trace'),
                  children: [
                    Text(stackTrace.toString()),
                  ],
                )),
          if (retry != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: FilledButton(
                child: const Text('Retry'),
                onPressed: () => retry,
              ),
            )
        ],
      ),
    );
  }
}

void showErrorSnackBar(BuildContext context, {String? error}) {
  final snackBar = SnackBar(
    /// need to set following properties for best effect of awesome_snackbar_content
    elevation: 0,
    behavior: SnackBarBehavior.floating,

    content: AwesomeSnackbarContent(
      title: 'Something went wrong',
      message: error ?? 'Please try again',
      contentType: ContentType.failure,
    ),
  );

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}
