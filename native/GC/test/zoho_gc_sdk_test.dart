import 'package:flutter_test/flutter_test.dart';
import 'package:zoho_gc_sdk/zoho_gc_sdk.dart';
import 'package:zoho_gc_sdk/zoho_gc_sdk_platform_interface.dart';
import 'package:zoho_gc_sdk/zoho_gc_sdk_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockZohoGcSdkPlatform
    with MockPlatformInterfaceMixin
    implements ZohoGcSdkPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final ZohoGcSdkPlatform initialPlatform = ZohoGcSdkPlatform.instance;

  test('$MethodChannelZohoGcSdk is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelZohoGcSdk>());
  });

  test('getPlatformVersion', () async {
    ZohoGcSdk zohoGcSdkPlugin = ZohoGcSdk();
    MockZohoGcSdkPlatform fakePlatform = MockZohoGcSdkPlatform();
    ZohoGcSdkPlatform.instance = fakePlatform;

    expect(await zohoGcSdkPlugin.getPlatformVersion(), '42');
  });
}
