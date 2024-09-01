import 'package:educational_institute/core/utils/router/app_router.dart';
import 'package:educational_institute/core/utils/theme/theme.dart';
import 'package:flutter/material.dart';

class EductionalInstitute extends StatelessWidget {
  const EductionalInstitute({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme(),
      darkTheme: AppTheme.darkTheme(),
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router(),
    );
  }
}
