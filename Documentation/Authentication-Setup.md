# Authentication Setup

Below details the steps on how to setup you Xcode project and application to use this framework and authenticate users.

## Setup with Netatmo

You will first need a developer account with Netatmo. To get this go to [https://dev.netatmo.com](dev.netatmo.com). Here you can create an account and login to the developer portal.

Once you have an account, you need to create an "app" in the Netatmo developer portal. Go to [https://dev.netatmo.com/apps](dev.netatmo.com/apps) and create an app (or select a previously created one).

Once you've filled in the required fields and save, you will be given a client ID and a client secret. Keep these handy as they'll be needed in your application.

You don't *need* to fill in any more details here (such as redirect URI or webhook URI), as you wont need these for your app (though you will need them if you want to have a web app as well).

**Please Note:** If you have any issues with any of the above, please contact Netatmo directly for support.

## Setup a Custom URL Scheme in Xcode 

Once you've got your client ID and client secret, you can now go into your Xcode project. Once you've created your project the first thing you need to do is create a custom URL scheme.

The URL scheme is used to redirect the user back into your app automatically once they've authorised themselves in Safari, and so the application can get the OAuth2 code to generate tokens with.

To do this, in the Project Navigator on the left, select your project and then your apps Target. Then select the "Info" tab. From here you should be able to see a collapsed section called "URL Types" at the bottom of the view. Expand this section and select the plus (+) button to create a new one.

Here you can enter you'r URL Scheme to identify your app. You don't have to make this too complicated but don't make it too simple as so it might clash with another app (for example **don't** use `netatmo`). Also, don't use spaces, use `-` or similar if you don't want to use a single word without spaces.

Once you've done this you have setup your custom URL Scheme and are ready to code. For more information on Custom URL Schemes, please refer to Apple's documentation about it directly. 

[Defining a Custom URL Scheme for your app](https://developer.apple.com/documentation/uikit/inter-process_communication/allowing_apps_and_websites_to_link_to_your_content/defining_a_custom_url_scheme_for_your_app)

## Setup in Code

Once you've setup you're Custom URL Scheme, you can now authenticate the user.

First, we listen to changes to authentication state:

```swift
listener = NetatmoManager.addAuthStateDidChangeListener { (authState) in
    
    // Handle state change
    switch authState {
    case .authorized:
        break // Fetch and/or present data
        
    case .unauthorized:
        break // Start login authentication process
        
    case .failed(let error):
        break // Present nice error to the user
        
    case .unknown, .tokenExpired:
        break // Most likely ignorable
    }
}
```

**Note:** `.unknown` should only occur when the framework is setting up, if `config(clientId:clientSecret:redirectURI:)` was not called or there was an issue configuring the framework. `.tokenExpired` can happen but no action needs to be taken, as when calling any method if the token is expired then it is automatically refreshed before trying the fetch again. It will only try to refresh the token once, and if it fails then the fetch call with return an error. 

You should keep track of the `listener` so that you can remove it when no longer needed with the following:

```swift
if let listener = self.listener {
    NetatmoManager.removeAuthStateDidChangeListener(with: listener)
}
```

Once you're listening to the authentication state, now you can get the URL to allow the user to login and present it with `SafariViewController` or `open(_:options:completionHandler:)`.

```swift
let url: URL
do {
    url = try NetatmoManager.authorizeURL(scope: [.readStation])
} catch {
    // Handle error
    return
}
UIApplication.shared.open(url, options: [:], completionHandler: nil)
```

**Note:** Make sure you pass in the correct scopes for the requests you wish to make. Each request will state what scope it requires, otherwise it can be found at [https://dev.netatmo.com](https://dev.netatmo.com).

3. Once the user is brought back to the app, the authentication state will change and trigger the listeners. From here you can then use all the `NetatmoWeather`, `NetatmoSecurity`, `NetatmoEnergy` and `NetatmoAircare` functions.

4. `NetatmoSwiftSDK` will keep track of the user's authentication state in the keychain across launches, and will refresh the token if required. However to logout the user and clear the keychain, call the following:

```swift
do {
    try NetatmoManager.logout()
} catch {
    // Handle error
}
```

## Note on Login with Username and Password

This framework does include a function to login via username and password, however it is marked as `internal` and not available for use outside of the unit tests. This is due to Netatmo's documentation stating that:

[Client credentials grant type](https://dev.netatmo.com/apidocumentation/oauth#client-credential)

> This method should only be used for personnal use and testing purpose.

Due to this, you should not rely on `authStateDidChangeListeners` to be called or `authState` to change correctly, as it is not meant to be used in production by apps. 
