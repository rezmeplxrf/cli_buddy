
import 'package:buddy_chat/scr/constant/theme.dart';
import 'package:buddy_chat/scr/presentation/layout.dart';
import 'package:buddy_chat/scr/presentation/widget/configuration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Buddy Chat',
      debugShowCheckedModeBanner: false,
      darkTheme: darkTheme,
      theme: lightTheme,
     
      routerConfig: _router,
      builder: EasyLoading.init(),
    );
  }
}

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    _animatedGoRoute(
      path: '/',
      pageBuilder: (context, state) => const Layout(),
    ),
    _animatedGoRoute(
      path: '/config',
      pageBuilder: (context, state) => const ConfigurationPage(),
    ),
  ],
);

GoRoute _animatedGoRoute({
  required String path,
  required Widget Function(BuildContext, GoRouterState) pageBuilder,
}) {
  return GoRoute(
    path: path,
    pageBuilder: (context, state) => CustomTransitionPage<void>(
      key: state.pageKey,
      child: pageBuilder(context, state),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurveTween(curve: Curves.easeInCubic).animate(animation),
          child: child,
        );
      },
    ),
  );
}
