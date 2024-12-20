import 'package:flutter/cupertino.dart';
import 'package:pmu_labs/components/locale/l10n/app_locale.dart';

extension LocalContextX on BuildContext{
  AppLocale get locale => AppLocale.of(this)!;
}