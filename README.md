# NetatmoSwiftSDK

<!-- [![SwiftPM](https://img.shields.io/badge/SwiftPM-compatible-brightgreen.svg?style=flat)](https://github.com/Carthage/Carthage) -->
<!-- [![Carthage](https://img.shields.io/badge/Carthage-compatible-brightgreen.svg?style=flat)](https://github.com/Carthage/Carthage) -->

![Swift](https://img.shields.io/badge/Swift-5.1-orange.svg)
![Platforms](https://img.shields.io/badge/Platforms-iOS-brightgreen.svg?style=flat)
[![Twitter](https://img.shields.io/badge/Twitter-@baza207-blue.svg?style=flat)](https://twitter.com/baza207)

NetatmoSwiftSDK is a Swift wrapper around the [Netatmo API](https://dev.netatmo.com).

This is currently a work in progress. There is a list of currently supported features listed below.

- [x] Authentication with OAuth2  
- [x] Weather  
- [x] Security
- [ ] Energy  
- [ ] AirCare  
- [x] Error Handling

## Prerequisites

Before you begin, ensure you have met the following requirements:

- Create a Netatmo developer account at: [https://dev.netatmo.com](https://dev.netatmo.com)
- Create a Netatmo app and generate a client ID and client secret for authentication at: [https://dev.netatmo.com/apps/](https://dev.netatmo.com/apps/)
- Follow the instructions in [Usage](#Usage) to get started adding NetatmoSwiftSDK in your app.

## Installation

Coming Soon!

## Usage

### Basic Setup

Once you have a client ID and client secret from [Netatmo Developer Portal](https://dev.netatmo.com/apps/) you will also need to create an URI in your Xcode project. To do this you can follow the steps to [Register Your URL Scheme](https://developer.apple.com/documentation/uikit/inter-process_communication/allowing_apps_and_websites_to_link_to_your_content/defining_a_custom_url_scheme_for_your_app) in the Apple documentation.

Once you have these items, you can import the `NetatmoSwiftSDK` framework in your project and set it up for use.

1. Import `NetatmoSwiftAPI` in your `AppDelegate`:

```
import NetatmoSwiftSDK
```

2. Setup `NetatmoSwiftAPI` by calling `configure(clientId:clientSecret:redirectURI:)` in `application(_:didFinishLaunchingWithOptions:)`, passing in your client ID and client secret from [Netatmo Developer Portal](https://dev.netatmo.com) as well as the URI you setup in Xcode Info tab.

```
NetatmoManager.configure(clientId: "<Client ID>", clientSecret: "<Client Secret>", redirectURI: "<Redirect URI>")
```

3. To deal with authentication callbacks you need to handle URL callbacks.

If you use a `SceneDelegate` then use the following:

```
func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
    
    guard let url = URLContexts.first?.url else {
        NSLog("No valid URL contexts")
        return
    }
    
    if (url.scheme == "<Redirect URI>") {
        NetatmoManager.authorizationCallback(with: url)
    } else {
        NSLog("No matching URL contexts")
    }
}
```

Otherwise use this in your `AppDelegate`:

```
func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
    
    if (url.scheme == "<Redirect URI>") {
        NetatmoManager.authorizationCallback(with: url)
        return true
    }
    
    NSLog("No matching URL contexts")
    return false
}
```

**Note:** If your app supports `UIWindowSceneDelegate`, then the url callback will not be called in you `UIApplicationDelegate`.

### Authentication

Once you've done the basic setup, you can now authenticate the user.

1.  Listen to changes to authentication state:

```
listener = NetatmoManager.addAuthStateDidChangeListener { (authState) in
    // Handle state change
}
```

You should keep track of the `listener` so that you can remove it when no longer needed with the following:

```
if let listener = self.listener {
    NetatmoManager.removeAuthStateDidChangeListener(with: listener)
}
```

2. Once you're listening to the authentication state, now you can get the URL to allow the user to login and present it with `SafariViewController` or `open(_:options:completionHandler:)`.

```
let url: URL
do {
    url = try NetatmoManager.authorizeURL(scope: [.readStation])
} catch {
    // Handle error
    return
}
let viewController = SafariViewController(url: url)
present(viewController, animated: true, completion: nil)
```

**Note:** Make sure you pass in the correct scopes for the requests you wish to make. Each request will state what scope it requires, otherwise it can be found at [https://dev.netatmo.com](https://dev.netatmo.com).

3. Once the user is brought back to the app, the authentication state will change and trigger the listeners. From here you can then use all the `NetatmoWeather`, `NetatmoSecurity`, `NetatmoEnergy` and `NetatmoAircare` functions.

4. `NetatmoSwiftAPI` will keep track of the user's authentication state in the keychain across launches, and will refresh the token if required. However to logout the user and clear the keychain, call the following:

```
do {
    try NetatmoManager.logout()
} catch {
    // Handle error
}
```

## Contributors

[James Barrow](https://github.com/baza207)

## License

[MIT Licence](LICENSE)
