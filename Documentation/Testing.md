# Testing

This project uses a `TestConfig.json` file that should be location in `/Tests/Test Config/`. Without this file all the tests will fail.

The `TestConfig.json` is a standard JSON file with a dictionary as a root item. It has the following items:

```json
{
    "clientId": <String>,
    "clientSecret": <String>,
    "username": <String>,
    "password": <String>,
    "redirectURI": <String>,
    "homeId": <String>,
    "eventId": <String>,
    "personId": <String>,
    "personId2": <String>,
    "faceId": <String>,
    "faceKey": <String>,
    "snapshotId": <String>,
    "snapshotKey": <String>,
    "vignetteId": <String>,
    "vignetteKey": <String>,
    "neLatitude": <Double>,
    "neLongitude": <Double>,
    "swLatitude": <Double>,
    "swLongitude": <Double>,
    "weatherDeviceId": <String>
}
```

**Note:** Tests use `login(username: String, password: String, ...)` and so will use the entered credentials directly rather than using OAuth2 tokens.
