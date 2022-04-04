import 'package:firebase_core/firebase_core.dart';

class config {
  static var api_key = "AIzaSyALHx4W_JTnLc6j-7954UiCg7mamP9Ob_8";
  static var api_id = "1:1010769436176:android:e73ff0f2ca4813bfef7495";
  static var messaging_sender_id = "1010769436176";
  static var project_id = "priceapp-e2127";
  static var storage_bucket = "priceapp-e2127.appspot.com";

  static FirebaseOptions get platformOptions {
    return FirebaseOptions(
      apiKey: api_key,
      appId: api_id,
      messagingSenderId: messaging_sender_id,
      projectId: project_id,
    );
  }
}
