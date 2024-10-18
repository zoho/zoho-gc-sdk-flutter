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
    case .show:
      show(arguments:arguments)
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
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  public func show(arguments: [String: Any]?){
        guard let orgId = arguments?["orgId"] as? String,
                let botId = arguments?["botId"] as? String,
                let domain = arguments?["domain"] as? String
          else { return }
          ZohoGC.show(orgId: orgId, botId: botId, domain: domain)
  }

   public func showFlow(arguments: [String: Any]?){
      guard let orgId = arguments?["orgId"] as? String,
              let flowId = arguments?["flowId"] as? String,
              let domain = arguments?["domain"] as? String
        else { return }
        ZohoGC.showFlow(orgId: orgId, flowId: flowId, domain: domain)
   }

   public func setSessionVariable(arguments: [String: Any]?){
      guard let botId = arguments?["botId"] as? String, let arguments = arguments?["sessionVariables"] as? [[String:String]] else { return }
      var sessionVariables: [String: String] = [:]
      arguments.forEach {
          if let key = $0["name"], let value = $0["value"] {
              sessionVariables[key] = value
          }
      }
      ZohoGC.setSessionVariables(botId: botId, sessionVariables: sessionVariables)
   }

    public func updateSessionVariable(arguments: [String: Any]?){
        guard let botId = arguments?["botId"] as? String, let arguments = arguments?["sessionVariables"] as? [[String:String]] else { return }
        var sessionVariables: [String: String] = [:]
        arguments.forEach {
           if let key = $0["name"], let value = $0["value"] {
               sessionVariables[key] = value
            }
        }
        ZohoGC.updateSessionVariables(botId: botId, sessionVariables: sessionVariables)
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

   private enum ZDGCAPI: String {
          case show
          case showFlow
          case setSessionVariable
          case updateSessionVariable
          case enableLog
          case clearData
          case setTheme
    }

}
