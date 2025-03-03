import 'package:flutter/material.dart';
import 'package:myapp/database/habit_database.dart';
import 'package:myapp/pages/home_page.dart';
import 'package:myapp/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:myapp/pages/login_page.dart';
import 'package:myapp/util/auth_util.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HabitDatabase.initialize();
  await HabitDatabase().saveFirstLaunchDate();

  ThemeProvider themeProvider = ThemeProvider();
  bool loggedIn = await AuthUtil.isLoggedIn();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HabitDatabase()),
        ChangeNotifierProvider(create: (context) => themeProvider),
      ],
      child: MyApp(isLoggedIn: loggedIn),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isLoggedIn ? const HomePage() : const LoginPage(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
