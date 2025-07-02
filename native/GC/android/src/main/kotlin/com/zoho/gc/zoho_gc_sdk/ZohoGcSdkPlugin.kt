package com.zoho.gc.zoho_gc_sdk

import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import android.app.Activity
import com.zoho.gc.ZohoGC
import com.zoho.gc.gc_base.ZDChatCallback
import com.zoho.gc.gc_base.ZConfigUtil
import com.zoho.gc.gc_base.ZDThemeType
import com.google.gson.Gson
import android.graphics.Color
import android.util.Log
import java.util.Locale


/** ZohoGcSdkPlugin */
class ZohoGcSdkPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    protected var activity: Activity? = null

    companion object {
        private var darkThemeBuilder: ZDTheme? = null
        private var lightThemeBuilder: ZDTheme? = null
        fun setThemeBuilder(theme: ZDTheme) {
            if (theme.isDarkMode) darkThemeBuilder = theme else lightThemeBuilder = theme
        }
        fun hideLocationSearch(value : Boolean) {
            ZConfigUtil.hideLocationSearch = value
        }
    }

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "zoho_gc_sdk")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        val arguments = call.arguments as? HashMap<String, Any>?
        when (call.method) {
            "enableLog" -> enableLog(arguments)
            "showFlow" -> showFlow(arguments)
            "setSessionVariable" -> setSessionVariable(arguments)
            "updateSessionVariable" -> updateSessionVariable(arguments)
            "clearData" -> clearData(arguments)
            "setTheme" -> setTheme(arguments)
            "setLocale" -> setLocale(arguments)
        }
    }


    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
    }


    override fun onDetachedFromActivityForConfigChanges() {
        activity = null
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivity() {
        activity = null
    }

    fun showFlow(arguments: HashMap<String, Any>?) {
        val orgId = arguments?.get("orgId") as? String ?: ""
        val botId = arguments?.get("flowId") as? String ?: ""
        val domain = arguments?.get("domain") as? String ?: ""
        val preferredLanguage = arguments?.get("preferredLanguage") as? String ?: ""
        activity?.let {
            ZohoGC.showFlow(it, orgId, botId, domain, preferredLanguage)
        }
    }

    fun setSessionVariable(arguments: HashMap<String, Any>?) {
        val botId = arguments?.get("botId") as? String ?: ""
        val sessionVariables =
            arguments?.get("sessionVariables") as? ArrayList<HashMap<String, Any>> ?: arrayListOf()
        ZohoGC.setSessionVariables(botId, sessionVariables)
    }

    fun updateSessionVariable(arguments: HashMap<String, Any>?) {
        val orgId = arguments?.get("orgId") as? String ?: ""
        val botId = arguments?.get("botId") as? String ?: ""
        val domain = arguments?.get("domain") as? String ?: ""
        val sessionVariables =
            arguments?.get("sessionVariables") as? ArrayList<HashMap<String, Any>> ?: arrayListOf()
        activity?.let {
            ZohoGC.updateSessionVariables(it, orgId, botId, domain, sessionVariables)
        }
    }

    fun clearData(arguments: HashMap<String, Any>?) {
        val botId = arguments?.get("botId") as? String ?: ""
        activity?.let {
            ZohoGC.clearData(it, botId, object : ZDChatCallback.ZDClearDataCallback {
                override fun onFailed(exception: Exception) {}
                override fun onSuccess() {}
            })
        }
    }

    fun enableLog(arguments: HashMap<String, Any>?) {
        val isLogEnabled = arguments?.get("isLogEnabled") as? Boolean ?: false
        ZohoGC.enableLog(isLogEnabled)
    }

    fun setTheme(arguments: HashMap<String, Any>?) {
        val gson = Gson()
        val themeType = when (arguments?.get("type") as Int) {
            1 -> ZDThemeType.DARK
            0 -> ZDThemeType.LIGHT
            else -> ZDThemeType.SYSTEM
        }
        ZConfigUtil.setThemeType(themeType);
        lightThemeBuilder?.let { lightTheme ->
            ZConfigUtil.setThemeBuilder(
                gson.fromJson(
                    gson.toJson(lightTheme),
                    com.zoho.gc.gc_base.ZDTheme::class.java
                )
            )
        }
        darkThemeBuilder?.let { darkTheme ->
            ZConfigUtil.setThemeBuilder(
                gson.fromJson(
                    gson.toJson(darkTheme),
                    com.zoho.gc.gc_base.ZDTheme::class.java
                )
            )
        }
    }

    fun setLocale(arguments: HashMap<String, Any>?) {
        val languageCode = arguments?.get("languageCode") as? String ?: Locale.getDefault().language
        val countryCode = arguments?.get("countryCode") as? String ?: Locale.getDefault().country
        val locale = Locale(languageCode, countryCode)
        ZConfigUtil.locale = locale
    }

}
