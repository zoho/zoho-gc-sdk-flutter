#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint zoho_gc_sdk.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'zoho_gc_sdk'
  s.version          = '1.0.0'
  s.summary          = 'The Guided Conversations (GC) mobile SDK'
  s.description      = <<-DESC
The Guided Conversations (GC) mobile SDK helps developers build a conversational self-service platform to achieve the best customer service.
                       DESC
  s.homepage         = 'https://help.zoho.com/portal/en/kb/desk/developer-space/guided-conversations'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'DeskMobile' => 'support@zohodesk.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'ZohoGCSDK', '1.3.2'
  s.platform = :ios, '13.0'
  s.ios.deployment_target  = '13.0'
end
