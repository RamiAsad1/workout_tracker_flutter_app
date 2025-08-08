import 'package:flutter/material.dart';

import 'package:workout_tracker/l10n/app_localizations.dart';
import 'package:workout_tracker/presentation/widgets/home%20screen/home_screen_contents.dart';
import 'package:workout_tracker/presentation/widgets/misc/background_container.dart';
import 'package:workout_tracker/screens/home%20screen/history_screen.dart';
import 'package:workout_tracker/screens/home%20screen/settings_screen.dart';

//TODO: add localization in the cubit classes + add workout edit (fix list not showing up + add sets and reps) and exercise details screen
//TODO: settings page (for now only contain units, language change option)
//TODO: history page (calendar of active days, last workout details)

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      HistoryScreen(),
      HomeScreenContents(),
      SettingsScreen(),
    ];

    return BackgroundContainer(
      child: Scaffold(
        appBar: AppBar(
          title: Text('W-Track', style: TextStyle(fontWeight: FontWeight.bold)),
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Colors.transparent,
        body: screens[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: (index) => setState(() => _selectedIndex = index),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: AppLocalizations.of(context)!.historyLabel,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: AppLocalizations.of(context)!.workoutLabel,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: AppLocalizations.of(context)!.settingsLabel,
            ),
          ],
        ),
      ),
    );
  }
}
