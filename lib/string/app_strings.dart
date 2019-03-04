import 'app_string_localized.dart';
import 'app_string_base.dart';
import '../include.dart';

export 'app_string_localized_delegate.dart';

class AppStrings {
  static AppStringBase getLocale(BuildContext context) {
    return AppStringLocalized.of(context).currentLocalized;
  }
}
