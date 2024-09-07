import 'package:fluent_ui/fluent_ui.dart' hide Page;
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Layout extends HookConsumerWidget {
  const Layout({ super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NavigationView(
      appBar: const NavigationAppBar(
        title: Text('NavigationView'),
      ),
      pane: NavigationPane(
        footerItems: [
          PaneItem(
            icon: const Icon(FluentIcons.settings),
            title: const Text('Settings'),
            body: Container(),
          ),
          PaneItemAction(
            icon: const Icon(FluentIcons.add),
            title: const Text('Add New Item'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
