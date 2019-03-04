import 'app_string_localized.dart';
import 'package:flutter/foundation.dart';
import '../include.dart';

class AppStringLocalizedDelegate extends StringLocalizedDelegate<AppStringLocalized> {
  @override
  Future<AppStringLocalized> load(Locale locale) {
    return new SynchronousFuture<AppStringLocalized>(AppStringLocalized(locale));
  }
  ///全局静态的代理
  static AppStringLocalizedDelegate delegate = new AppStringLocalizedDelegate();
}
