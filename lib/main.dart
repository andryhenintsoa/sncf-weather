import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'core/service/authentification_service.dart';
import 'core/service_locator.dart';
import 'ui/app_router.dart';
import 'ui/styling.dart';

// TODO
// - Save in SharedPreferences the city
// - Update time to local user

Future<void> main() async {
  setupLocator();
  await dotenv.load(fileName: ".env");
  Intl.defaultLocale = "fr_FR";
  runApp(MultiProvider(providers: [
    StreamProvider(
      initialData: null,
      create: (context) =>
      locator<AuthenticationService>().userController.stream,
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SNCF Weather',
      initialRoute: AppRouter.initialRoute,
      onGenerateRoute: AppRouter.generateRoute,
      debugShowCheckedModeBanner: false,
      theme: theme(),
    );
  }
}
