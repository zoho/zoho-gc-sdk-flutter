## 1.0.5


### Android
    - Fixed a crash issue while previewing an attachment.
    - Fixed a crash in the location component when the map API key was not found.
    - Fixed a message content margin issue.

### iOS
    - Fixed a message content margin issue.


## 1.0.4

### In Android & iOS
    - Added a public API (hideEndChatPopupWindow) to hide or show the end chat popup.
    - Added a public API (hideLanguageMismatchPopupWindow) to hide or show the language mismatch popup.


## 1.0.3


### In Android & iOS
    - Added a public API to show or hide the language switch option.


## 1.0.2


### In Android:

    - Introduced Multilingual support in GC Flows to enhance localization.
    - Added support for GC Flow customization on the mobile side, enabling more flexible UI behaviour.
    - Implemented chat export functionality for improved conversation management.
    - Deprecated the showWidget API starting from this version.

### In iOS:

    - Introduced Multilingual support in GC Flows to enhance localization.
    - Added support for GC Flow customization on the mobile side, enabling more flexible UI behaviour.
    - Implemented chat export functionality for improved conversation management.
    - Deprecated the showWidget API starting from this version.
    - Updated build configurations to support Xcode 16, in line with Apple’s latest requirements.

### API Changes
    - Update your implementation to use the latest showFlow method with the preferredLanguage parameter to take advantage of multilingual support in flows.    

| Status       | Method Signature                                                          | Notes                                              |
|--------------|---------------------------------------------------------------------------|----------------------------------------------------|
| Deprecated   | `static Future<void> show(String orgId, String widgetId, String domain)`  | Replaced by `showFlow()` from v1.0.0               |
|--------------|---------------------------------------------------------------------------|----------------------------------------------------|
| Old API      | `static Future<void> showFlow(String orgId, String flowId, String domain)`| Initial replacement for `show()`                   |
|--------------|---------------------------------------------------------------------------|----------------------------------------------------|
| Updated API  | `static Future<void> showFlow(String orgId, String flowId, String domain, | Now includes optional `preferredLanguage`          |
|              |  {String preferredLanguage = " "})`                                       |                                                    |
|--------------|---------------------------------------------------------------------------|----------------------------------------------------|
