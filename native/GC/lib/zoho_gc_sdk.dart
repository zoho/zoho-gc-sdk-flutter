import 'dart:ui';
import 'zoho_gc_sdk_platform_interface.dart';
import 'package:zoho_gc_sdk/ThemeConstant.dart';

class ZohoGcSdk {
  // show(String orgId, String botId, String domain)
  static Future<void> showFlow(String orgId, String flowId, String domain,{ String preferredLanguage = ""}) => ZohoGcSdkPlatform.instance.showFlow(orgId, flowId, domain, preferredLanguage);
  static Future<void> setSessionVariable(String botId, List<Map<String, String>> sessionVariables) => ZohoGcSdkPlatform.instance.setSessionVariable(botId, sessionVariables);
  static Future<void> updateSessionVariable(String orgId, String botId, String domain, List<Map<String, String>> sessionVariables) => ZohoGcSdkPlatform.instance.updateSessionVariable(orgId, botId, domain, sessionVariables);
  static Future<void> enableLog(bool isLogEnabled) => ZohoGcSdkPlatform.instance.enableLog(isLogEnabled);
  static Future<void> clearData(String botId) => ZohoGcSdkPlatform.instance.clearData(botId);
  static Future<void> setTheme(ZDThemeType type) => ZohoGcSdkPlatform.instance.setTheme(type);
  static Future<void> setLocale(Locale locale) => ZohoGcSdkPlatform.instance.setLocale(locale.languageCode, locale.countryCode);


}
