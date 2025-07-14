// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:workout_tracker/l10n/app_localizations.dart';

const String LANGUAGE_CODE = 'languageCode';

const String ENGLISH = 'en';
const String ARABIC = 'ar';

Future<Locale> setLocale(String languageCode) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  await pref.setString(LANGUAGE_CODE, languageCode);
  return _locale(languageCode);
}

Future<Locale> getLocale() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String languageCode = pref.getString(LANGUAGE_CODE) ?? ENGLISH;
  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  switch (languageCode) {
    case ENGLISH:
      return Locale(ENGLISH, "GB");
    case ARABIC:
      return Locale(ARABIC, "PS");
    default:
      return Locale(ENGLISH, "GB");
  }
}

AppLocalizations translation(BuildContext context) {
  return AppLocalizations.of(context)!;
}
