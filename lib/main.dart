import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kyogojo_pay/providers/request_provider.dart';
import 'package:kyogojo_pay/providers/signup_provider.dart';
import 'package:kyogojo_pay/routes/index.dart';
import 'package:kyogojo_pay/styles/design_system.dart';
import 'package:provider/provider.dart';

Future main() async {
  // await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
    ),
  );
  // setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends HookWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (contex) => RequestProvider()),
        ChangeNotifierProvider(create: (contex) => SignupDataProvider()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) {
          final router = RouteBuilderGo.buildRoutes;

          return Theme(
            data:
                ThemeData(fontFamily: 'Poppins', brightness: Brightness.light),
            child: CupertinoApp.router(
              debugShowCheckedModeBanner: false,
              theme: ThemeSystem.themeData,
              localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
                DefaultMaterialLocalizations.delegate,
                DefaultWidgetsLocalizations.delegate,
                DefaultCupertinoLocalizations.delegate,
              ],
              routerConfig: router,
            ),
          );
        },
      ),
    );
  }
}
