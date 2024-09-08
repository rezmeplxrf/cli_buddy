import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SysPromptsDropdownWidget extends HookConsumerWidget {
  const SysPromptsDropdownWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        // TODO: Allow selecting custom system prompts which will be saved in /prompts.
        // need to create a model and send it to the server and save there
        DropdownButton<String>(
          onChanged: (value) => {},
          items: [
            'Option 1',
            'Option 2',
            'Option 3',
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Row(
                children: [
                  const Icon(Icons.star),
                  const SizedBox(width: 10),
                  Text(value),
                ],
              ),
            );
          }).toList(),
        ),
        IconButton(onPressed: () {}, icon: const Icon(Icons.send)),
      
      ],
    );
  }
}
