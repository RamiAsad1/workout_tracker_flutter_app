import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workout_tracker/l10n/app_localizations.dart';

import '../../app_root.dart';
import 'package:workout_tracker/classes/language.dart';
import 'package:workout_tracker/language_constants.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsScreen> {
  String _selectedUnit = 'kg';
  Language _selectedLanguage = Language.languages().first;

  final List<String> _units = ['kg', 'lb'];

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final savedUnit = prefs.getString('unit') ?? 'kg';
    final savedLangCode =
        prefs.getString('languageCode') ?? _selectedLanguage.languageCode;

    setState(() {
      _selectedUnit = savedUnit;
      _selectedLanguage = Language.languages().firstWhere(
        (lang) => lang.languageCode == savedLangCode,
        orElse: () => Language.languages().first,
      );
    });
  }

  Future<void> _saveUnit(String unit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('unit', unit);
  }

  Future<void> _saveLanguage(Language language) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('languageCode', language.languageCode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              title: Text(AppLocalizations.of(context)!.unitsLabel),
              trailing: DropdownButton<String>(
                value: _selectedUnit,
                items: _units
                    .map(
                      (unit) =>
                          DropdownMenuItem(value: unit, child: Text(unit)),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedUnit = value!;
                  });
                  _saveUnit(value!);
                },
              ),
            ),
            const Divider(),
            ListTile(
              title: Text(AppLocalizations.of(context)!.languageLabel),
              trailing: DropdownButton<Language>(
                underline: const SizedBox(),
                value: _selectedLanguage,
                items: Language.languages()
                    .map(
                      (lang) => DropdownMenuItem<Language>(
                        value: lang,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(lang.flag),
                            const SizedBox(width: 8),
                            Text(lang.name),
                          ],
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (Language? language) async {
                  if (language != null) {
                    setState(() {
                      _selectedLanguage = language;
                    });

                    await _saveLanguage(language);

                    Locale locale = await setLocale(language.languageCode);
                    // ignore: use_build_context_synchronously
                    AppRoot.setLocale(context, locale);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
