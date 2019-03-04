import '../include.dart';
import 'app_string_base.dart';
import 'app_string_zh.dart';
import 'app_string_en.dart';

class AppStringLocalized extends StringLocalized<AppStringBase> {
  AppStringLocalized(Locale locale) : super(locale);

  @override
  Map<String, AppStringBase> localizedValues() {
    return {
      Strings.ZH: AppStringZh(),
      Strings.EN: AppStringEn(),
    };
  }

  //通过 Localizations 加载当前的 String
  ///获取对应的 StringBase
  static AppStringLocalized of(BuildContext context) {
    return Localizations.of(context, AppStringLocalized);
  }
}
