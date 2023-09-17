import 'package:syntonic_components/gen/l10n/app_localizations.dart';
import 'package:syntonic_components/services/navigation_service.dart';

class LocalizationService {
  AppLocalizations get localize {
    return AppLocalizations.of(NavigationService().navigatorKey.currentContext!)!;
  }
}