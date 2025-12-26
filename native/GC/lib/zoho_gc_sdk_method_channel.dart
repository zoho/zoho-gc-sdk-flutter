import 'dart:ffi';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'package:zoho_gc_sdk/ThemeConstant.dart';

import 'zoho_gc_sdk_platform_interface.dart';

/// An implementation of [ZohoGcSdkPlatform] that uses method channels.
class MethodChannelZohoGcSdk extends ZohoGcSdkPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('zoho_gc_sdk');

  @override
  Future<void> showFlow(String orgId, String flowId, String domain, String preferredLanguage) async {
    await methodChannel.invokeMethod("showFlow", {"orgId": orgId, "flowId": flowId, "domain": domain, "preferredLanguage": preferredLanguage});
  }

  /// ASAP GC set session variable channel method
  @override
  Future<void> setSessionVariable(String botId,List<Map<String, String>> sessionVariables) async {
    await methodChannel.invokeMethod('setSessionVariable', {"botId": botId, "sessionVariables": sessionVariables});
  }

  /// ASAP GC update session variable channel method
  @override
  Future<void> updateSessionVariable(String orgId, String botId, String domain,List<Map<String, String>> sessionVariables) async {
    await methodChannel.invokeMethod('updateSessionVariable', {"orgId": orgId, "botId": botId, "domain": domain, "sessionVariables": sessionVariables});
  }

  @override
  Future<void> enableLog(bool isLogEnabled) async {
    await methodChannel.invokeMethod('enableLog', {"isLogEnabled" : isLogEnabled});
  }

  @override
  Future<void> clearData(String botId) async {
    await methodChannel.invokeMethod('clearData', {"botId" : botId});
  }

  @override
  Future<void> setTheme(ZDThemeType type) async {
    await methodChannel.invokeMethod("setTheme", {"type":type.rawValue});
  }

  @override
  Future<void> setLocale(String languageCode, String? countryCode) async {
    await methodChannel.invokeMethod('setLocale', {"languageCode": languageCode, "countryCode": countryCode,});
  }

  @override
  Future<void> updateLanguageIcon(bool isVisible) async {
    await methodChannel.invokeMethod('updateLanguageIcon', {"isVisible":isVisible});
  }

  @override
  Future<void> hideEndChatPopupWindow(bool isHide) async {
    await methodChannel.invokeMethod('hideEndChatPopupWindow', {"isHide":isHide});
  }

  @override
  Future<void> hideLanguageMismatchPopupWindow(bool isHide) async {
    await methodChannel.invokeMethod('hideLanguageMismatchPopupWindow', {"isHide":isHide});
  }
}
