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
