import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// label for the history bottom navigation bar item
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get historyLabel;

  /// label for the workout bottom navigation bar item
  ///
  /// In en, this message translates to:
  /// **'Workouts'**
  String get workoutLabel;

  /// label for the settings bottom navigation bar item
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsLabel;

  /// Error message displayed when exercises fail to load
  ///
  /// In en, this message translates to:
  /// **'Failed to load exercises'**
  String get exerciseLoadError;

  /// Error message displayed when adding an exercise fails
  ///
  /// In en, this message translates to:
  /// **'Failed to add exercise'**
  String get exerciseAddError;

  /// Error message displayed when deleting an exercise fails
  ///
  /// In en, this message translates to:
  /// **'Failed to delete exercise'**
  String get exerciseDeleteError;

  /// Error message displayed when updating an exercise fails
  ///
  /// In en, this message translates to:
  /// **'Failed to update exercise'**
  String get exerciseUpdateError;

  /// Error message displayed when workouts fail to load
  ///
  /// In en, this message translates to:
  /// **'Failed to load workouts'**
  String get workoutLoadError;

  /// Error message displayed when adding a workout fails
  ///
  /// In en, this message translates to:
  /// **'Failed to add workout'**
  String get workoutAddError;

  /// Error message displayed when deleting a workout fails
  ///
  /// In en, this message translates to:
  /// **'Failed to delete workout'**
  String get workoutDeleteError;

  /// Error message displayed when updating a workout fails
  ///
  /// In en, this message translates to:
  /// **'Failed to update workout'**
  String get workoutUpdateError;

  /// Placeholder text for the exercise search bar
  ///
  /// In en, this message translates to:
  /// **'Search exercises...'**
  String get searchBarHint;

  /// Label for the screen displaying all exercises
  ///
  /// In en, this message translates to:
  /// **'All Exercises'**
  String get allExercisesLabel;

  /// Message displayed when no exercises match the search criteria
  ///
  /// In en, this message translates to:
  /// **'No exercises found'**
  String get noExercisesFoundErrorMessage;

  /// Label for the section displaying user's workouts
  ///
  /// In en, this message translates to:
  /// **'My Workouts'**
  String get myWorkoutsLabel;

  /// Message displayed when no workouts are found
  ///
  /// In en, this message translates to:
  /// **'You have no workouts yet.\nStart by adding some exercises!'**
  String get noWorkoutsFoundErrorMessage;

  /// Label for displaying the last session date of a workout
  ///
  /// In en, this message translates to:
  /// **'Last session was: {date}'**
  String lastSessionLabel(String date);

  /// Label for the button to add a new workout
  ///
  /// In en, this message translates to:
  /// **'Add Workout'**
  String get addWorkoutLabel;

  /// Label for the workout name input field
  ///
  /// In en, this message translates to:
  /// **'Workout Name'**
  String get workoutNameLabel;

  /// Error message displayed when the workout name input is empty
  ///
  /// In en, this message translates to:
  /// **'Enter a workout name'**
  String get workoutNameError;

  /// Label for the workout notes input field
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get workoutNotesLabel;

  /// Label for the button to add an exercise to a workout
  ///
  /// In en, this message translates to:
  /// **'Add Exercise'**
  String get addExerciseBtnLabel;

  /// Label for the button to save a workout
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveWorkoutBtnLabel;

  /// Message displayed when an exercise is successfully added to a workout
  ///
  /// In en, this message translates to:
  /// **'Exercise added'**
  String get exerciseAddedLabel;

  /// Message displayed when an exercise is successfully deleted from a workout
  ///
  /// In en, this message translates to:
  /// **'Exercise deleted'**
  String get exerciseDeletedLabel;

  /// Message displayed when a workout is successfully saved
  ///
  /// In en, this message translates to:
  /// **'Workout saved'**
  String get workoutSavedLabel;

  /// Message displayed when a workout is successfully deleted
  ///
  /// In en, this message translates to:
  /// **'Workout deleted'**
  String get workoutDeletedLabel;

  /// Label for the units selection in settings
  ///
  /// In en, this message translates to:
  /// **'Units'**
  String get unitsLabel;

  /// Label for the language selection in settings
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageLabel;

  /// Title for the description card in the exercise details screen
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get descriptionCardTitle;

  /// Title for the weight type card in the exercise details screen
  ///
  /// In en, this message translates to:
  /// **'Weight Type'**
  String get weightTypeCardTitle;

  /// Title for the muscle group card in the exercise details screen
  ///
  /// In en, this message translates to:
  /// **'Muscle Group'**
  String get muscleGroupCardTitle;

  /// Title for the weight card in the exercise details screen
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get weightCardTitle;

  /// Label for the reps done input in the exercise details screen
  ///
  /// In en, this message translates to:
  /// **'Reps Done'**
  String get repsDoneLabel;

  /// Error message displayed when the reps done input is empty
  ///
  /// In en, this message translates to:
  /// **'Enter the number of reps done'**
  String get repsDoneError;

  /// Error message displayed when the weight input is empty
  ///
  /// In en, this message translates to:
  /// **'Enter the weight lifted'**
  String get weightError;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
