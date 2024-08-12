import 'package:flutter/material.dart';

import 'config/constants/enviroment.dart';
import 'config/routes/app_rotes.dart';
import 'config/theme/app_theme.dart';

void main() async{
  await Enviroment.initEnviroment();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      theme: AppTheme().getTheme(),
      //theme: AppTheme().getTheme(),
    );
  }
}
