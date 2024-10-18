import 'dart:ffi';
import 'dart:ui';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:zoho_gc_sdk/ThemeConstant.dart';

import 'zoho_gc_sdk_method_channel.dart';

abstract class ZohoGcSdkPlatform extends PlatformInterface {
  /// Constructs a ZohoGcSdkPlatform.
  ZohoGcSdkPlatform() : super(token: _token);

  static final Object _token = Object();

  static ZohoGcSdkPlatform _instance = MethodChannelZohoGcSdk();

  /// The default instance of [ZohoGcSdkPlatform] to use.
  ///
  /// Defaults to [MethodChannelZohoGcSdk].
  static ZohoGcSdkPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ZohoGcSdkPlatform] when
  /// they register themselves.
  static set instance(ZohoGcSdkPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> show(String orgId, String botId, String domain);

  Future<void> showFlow(String orgId, String flowId, String domain);

  Future<void> setSessionVariable(String botId, List<Map<String, String>> sessionVariables);

  Future<void> updateSessionVariable(String orgId, String botId, String domain, List<Map<String, String>> sessionVariables);

  Future<void> enableLog(bool isLogEnabled);

  Future<void> clearData(String botId);

  Future<void> setTheme(ZDThemeType type);

  Future<void> setLocale(String languageCode, String? countryCode);

}
