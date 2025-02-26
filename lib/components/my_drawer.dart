import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/theme/theme_provider.dart';
import 'package:myapp/util/sharepref.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  Future<bool> getIsDarkMode() async {
    return await getSharedPreferencesBool('darkMode');
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Center(
        child: FutureBuilder<bool>(
          future: getIsDarkMode(),
          initialData: false, // Default value while loading
          builder: (context, snapshot) {

            if (snapshot.hasError) {
              return const Text("Error loading theme");
            }

            return CupertinoSwitch(
              value: snapshot.data ?? false,
              onChanged: (value) {
                Provider.of<ThemeProvider>(context, listen: false)
                    .toggleTheme();
              },
            );
          },
        ),
      ),
    );
  }
}