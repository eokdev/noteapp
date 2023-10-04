import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noteapp/constants/appColors.dart';

import 'package:noteapp/routes/appRouter.dart';
import 'package:noteapp/services/darkModeServices.dart';
import 'package:noteapp/utils/colorsLogic.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(
    BuildContext context,
  ) {
    final darkMode = ref.watch(darkModeProvider);
    final randomColor = getRandomColor();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: darkMode ? black : Colors.white,
      statusBarIconBrightness: darkMode ? Brightness.light : Brightness.dark,
    ));
    return MaterialApp.router(
      title: 'Note Taking',
      debugShowCheckedModeBanner: false,
      color: randomColor,
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('zh', 'HK'),
      ],
      routerConfig: router,
    );
  }
}
