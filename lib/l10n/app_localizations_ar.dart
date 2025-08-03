// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get historyLabel => 'التاريخ';

  @override
  String get workoutLabel => 'التمارين';

  @override
  String get settingsLabel => 'الإعدادات';

  @override
  String get exerciseLoadError => 'فشل تحميل التمارين';

  @override
  String get exerciseAddError => 'فشل إضافة التمرين';

  @override
  String get exerciseDeleteError => 'فشل حذف التمرين';

  @override
  String get exerciseUpdateError => 'فشل تحديث التمرين';

  @override
  String get workoutLoadError => 'فشل تحميل التمارين الرياضية';

  @override
  String get workoutAddError => 'فشل إضافة التمرين الرياضي';

  @override
  String get workoutDeleteError => 'فشل حذف التمرين الرياضي';

  @override
  String get workoutUpdateError => 'فشل تحديث التمرين الرياضي';

  @override
  String get searchBarHint => 'ابحث عن تمارين...';

  @override
  String get allExercisesLabel => 'جميع التمارين';

  @override
  String get noExercisesFoundErrorMessage => 'لم يتم العثور على تمارين';

  @override
  String get myWorkoutsLabel => 'تماريني';

  @override
  String get noWorkoutsFoundErrorMessage =>
      'ليس لديك تمارين بعد.\nابدأ بإضافة بعض التمارين!';

  @override
  String lastSessionLabel(String date) {
    return 'الجلسة الأخيرة كانت: $date';
  }

  @override
  String get addWorkoutLabel => 'إضافة تمرين رياضي';

  @override
  String get workoutNameLabel => 'اسم التمرين';

  @override
  String get workoutNameError => 'أدخل اسمًا للتمرين';

  @override
  String get workoutNotesLabel => 'ملاحظات';

  @override
  String get addExerciseBtnLabel => 'إضافة تمرين';

  @override
  String get saveWorkoutBtnLabel => 'حفظ';
}
