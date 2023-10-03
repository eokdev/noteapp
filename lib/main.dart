import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:noteapp/routes/appRouter.dart';
import 'package:noteapp/utils/colorsLogic.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
       final randomColor = getRandomColor();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
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
