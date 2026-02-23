# GenesisKitSample

A minimal TikTok-style vertical video feed sample using **GenesisKit**.

This repo intentionally **does not include an `.xcodeproj`**. You create the Xcode project locally (2 minutes) and add these source files.

## Requirements

- iOS 13+
- Xcode 15+

## 1) Create the Xcode project

1. Open Xcode
2. File → New → Project… → iOS → **App**
3. Product Name: `GenesisKitSampleApp`
4. Interface: **SwiftUI**
5. Language: **Swift**
6. Save it anywhere (you can also save it inside this repo).

## 2) Add GenesisKit via Swift Package Manager

In Xcode:

1. File → Add Package Dependencies…
2. Add:

```
https://github.com/femivita/GenesisKit.git
```

3. Choose version rule: **Up to Next Major** from `1.0.5`
4. Add products to your app target:

- `GenesisKitCore`
- `GenesisKitPlayer`

## 3) Add the sample source files

Copy the Swift files from:

- `GenesisKitSampleApp/Sources/`

Into your Xcode app target (drag-and-drop them into the project navigator and ensure they’re added to the app target).

## 4) Run

Build and run on device or simulator.

## What this demonstrates

- **UIKit vertical pager** (`UICollectionView` paging) as the playback engine.
- **SwiftUI wrapper** using `UIViewControllerRepresentable`.
- **`GKPlayersManager` pooling** with `prerenderDistance` and `preloadDistance`.
- **Resolution preference** via `preferredVideoResolution`.

## Notes

- This sample uses a few public MP4/HLS URLs for demonstration. Replace them with your own content.

## References (background reading)

- https://fabernovel.github.io/2021-01-14/build-custom-ios-player
- https://developer.apple.com/forums/thread/729370
- https://stackoverflow.com/questions/51714748/addperiodictimeobserver-keeps-avplayer-instances
