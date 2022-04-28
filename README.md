# price_app
This flutter project is used to view price from fire store and update it with track of record for later references  

## Before running this flutter project. Please ensure:

- Set up firebase project for firestore backend service.
  1. Guide: [How to set up Firebase](https://firebase.google.com/docs/guides)
  2. For Android: [Add Firebase to your Android project](https://firebase.google.com/docs/android/setup)
- Configure back with missing file
  1. `google-service.json` and `config/config.dart` is missing, both of these files are required 
  2. config.dart sample is based from [this](https://github.com/firebase/flutterfire/blob/master/packages/cloud_firestore/cloud_firestore/example/lib/firebase_config.dart)
- Made sure that `pubspec.yaml` is included and the link is accessible. 
  1. There are extension use during development, please run `flutter pub get`
  >Some may said that the pubspec.yaml could not fetch the proper link, suggest run `flutter clean` to remove all the library and redownload again using `flutter pub get`
