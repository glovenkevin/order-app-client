import 'package:firebase_core/firebase_core.dart';

import '../../firebase_options.dart';

class FirebaseAppHelper {
  static Future<FirebaseApp> getInstance() async {
    return await Firebase.initializeApp(
      name: 'order-app-ot',
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}
