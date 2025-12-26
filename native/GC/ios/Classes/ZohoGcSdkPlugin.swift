import Flutter
import UIKit
import ZohoGCSDK

public class ZohoGcSdkPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "zoho_gc_sdk", binaryMessenger: registrar.messenger())
    let instance = ZohoGcSdkPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }


  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    let arguments: [String: Any]? = call.arguments as? Dictionary<String, Any>
    switch ZDGCAPI(rawValue:call.method) {
     case .showFlow:
        showFlow(arguments: arguments)
     case .setSessionVariable:
        setSessionVariable(arguments:arguments)
     case .updateSessionVariable:
        updateSessionVariable(arguments: arguments)
     case .enableLog:
           enableLog(arguments: arguments)
     case .clearData:
            clearData(arguments: arguments)
     case .setTheme:
            setTheme(arguments:arguments)
    case .updateLanguageIcon:
        updateLanguageIcon(arguments: arguments)
    case .hideEndChatPopupWindow:
        hideEndChatPopUp(arguments: arguments)
    case .hideLanguageMismatchPopupWindow:
        hideLanguageMismatchPopupWindow(arguments: arguments)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
    
    public func updateLanguageIcon(arguments: [String: Any]?){
        guard let visibility = arguments?["isVisible"] as? Bool else {return}
        ZohoGC.updateLanguageIcon(isEnable: visibility)
    }

   public func showFlow(arguments: [String: Any]?){
      guard let orgId = arguments?["orgId"] as? String,
              let flowId = arguments?["flowId"] as? String,
              let domain = arguments?["domain"] as? String,
              let preferredLanguage = arguments?["preferredLanguage"] as? String
        else { return }
       ZohoGC.showFlow(orgId: orgId, flowId: flowId, domain: domain, preferredLanguage: preferredLanguage)
   }

   public func setSessionVariable(arguments: [String: Any]?){
      guard let botId = arguments?["botId"] as? String, let arguments = arguments?["sessionVariables"] as? [[String:Any]] else { return }
      ZohoGC.setSessionVariables(botId: botId, sessionVariables: arguments)
   }

    public func updateSessionVariable(arguments: [String: Any]?){
        guard let botId = arguments?["botId"] as? String, let arguments = arguments?["sessionVariables"] as? [[String:Any]] else { return }
        ZohoGC.updateSessionVariables(botId: botId, sessionVariables: arguments)
    }

     public func enableLog(arguments: [String: Any]?){
            guard let isLogEnabled = arguments?["isLogEnabled"] as? Bool
                 else { return }

            ZohoGC.enableLog(isLogEnabled: isLogEnabled)
     }

      public func clearData(arguments: [String: Any]?){
           guard let botId = arguments?["botId"] as? String
                else { return }

           ZohoGC.clearData(botId: botId)
      }

   public func setTheme(arguments: [String: Any]?){
         guard let themeType = arguments?["type"] as? Int,
                let type = ZDThemeType(rawValue: themeType)
              else { return }
         ZDThemeManager.setTheme(type:type)
      }

    public func hideEndChatPopUp(arguments: [String: Any]?) {
        guard let isHide = arguments?["isHide"] as? Bool else {return}
        ZohoGC.hideEndChatPopupWindow(isHide: isHide)
    }

    public func hideLanguageMismatchPopupWindow(arguments: [String: Any]?) {
        guard let isHide = arguments?["isHide"] as? Bool else {return}
        ZohoGC.hideLanguageMismatchPopupWindow(isHide: isHide)
    }

   private enum ZDGCAPI: String {
          case showFlow
          case setSessionVariable
          case updateSessionVariable
          case enableLog
          case clearData
          case setTheme
          case updateLanguageIcon
          case hideEndChatPopupWindow
          case hideLanguageMismatchPopupWindow
    }

}
