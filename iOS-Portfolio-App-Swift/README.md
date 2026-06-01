# HireTimSF iOS Portfolio

This is a SwiftUI conversion of the Kotlin/Jetpack Compose Android portfolio app.

## What Was Ported

- Profile header with local profile image
- About sections and remote photo carousel
- API-backed portfolio project list and project detail screens
- API-backed blog list and blog detail screens
- Contact sheet with email and social links
- Search across about, portfolio, and blog content
- Settings, theme preference, app info, privacy, rating, and data deletion flow
- First-launch onboarding converted from the Android welcome pages
- SwiftUI vector animations inspired by the Android onboarding animated vector drawables
- iOS side navigation drawer with profile, portfolio, blog, settings, and contact actions
- iOS app icon PNGs generated from the Android Play Store icon and registered in `Info.plist`
- Android `profile.webp` converted to bundled iOS PNG scale variants
- Android profile header vector background converted to a SwiftUI constellation canvas
- Android light/dark accent and profile header colors mapped into SwiftUI dynamic colors

## Build

Open `iOS-Portfolio-App-Swift.xcodeproj` in Xcode 26.5 or later and run the `iOS-Portfolio-App-Swift` scheme on an iOS simulator.

The app uses local Swift data and remote image URLs. No third-party packages are required.

Command-line build used for validation:

```bash
xcodebuild -project iOS-Portfolio-App-Swift.xcodeproj -target iOS-Portfolio-App-Swift -configuration Debug -sdk iphoneos26.5 CODE_SIGNING_ALLOWED=NO build
```

The `Assets.xcassets` folder contains generated icons copied from the Android Play Store icon. The profile image is also bundled directly as `profile.png` so the project can build on local Xcode installs where asset catalog thinning is blocked by a simulator runtime mismatch.
