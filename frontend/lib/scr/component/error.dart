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
    return Center(
        child: Column(
      children: [
        Text(error ?? 'Something went wrong'),
        if (stackTrace != null)
          ExpansionPanelList(
            children: [
              ExpansionPanel(
                headerBuilder: (context, isExpanded) {
                  return const Text('Stack trace');
                },
                body: Text(stackTrace.toString()),
                isExpanded: true,
              ),
            ],
          ),
        if (retry != null)
          FilledButton(
            child: const Text('Retry'),
            onPressed: () => retry,
          )
      ],
    ));
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
