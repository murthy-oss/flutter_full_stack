import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_full_stack/core/local_db/shared_prefs_manager.dart';
import 'package:flutter_full_stack/design/app_theme.dart';
import 'package:flutter_full_stack/features/app.dart';
import 'package:flutter_full_stack/features/onboarding/ui/onboarding_screen.dart';
import 'package:flutter_full_stack/firebase_options.dart';
import 'package:onboarding/onboarding.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesmanager.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.darkTheme,
      home: DecidePage(),
    );
  }
}