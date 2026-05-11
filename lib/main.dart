import 'package:flutter/foundation.dart' show kIsWeb, defaultTargetPlatform, TargetPlatform;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/dashboard_screen.dart';
import 'providers/auth_provider.dart';
import 'providers/patient_provider.dart';
import 'providers/intubation_provider.dart';
import 'services/database_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    databaseFactory = databaseFactoryFfiWeb;
  } else if (defaultTargetPlatform == TargetPlatform.windows || defaultTargetPlatform == TargetPlatform.linux) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }
  await DatabaseService.instance.database; // Initialise / Ouvre la base de données
  runApp(const IntubationApp());
}

class IntubationApp extends StatelessWidget {
  const IntubationApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => PatientProvider()),
        ChangeNotifierProvider(create: (_) => IntubationProvider()),
      ],
      child: MaterialApp(
        title: 'Intubation App',
        theme: ThemeData.dark().copyWith(
          primaryColor: Colors.teal,
          scaffoldBackgroundColor: const Color(0xFF121212),
          appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF1E1E1E)),
        ),
        initialRoute: '/login',
        routes: {
          '/login': (context) => const LoginScreen(),
          '/register': (context) => const RegisterScreen(),
          '/dashboard': (context) => const DashboardScreen(),
        },
      ),
    );
  }
}
