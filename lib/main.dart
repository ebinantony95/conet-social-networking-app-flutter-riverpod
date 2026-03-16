import 'package:conet_app/app.dart';
import 'package:conet_app/features/profile/model/profile_model.dart';
import 'package:conet_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Hive.initFlutter();

  Hive.registerAdapter(UserProfileAdapter());
  // 👇 OPEN THE BOX
  await Hive.openBox<UserProfile>('profileBox');
  runApp(ProviderScope(child: const App()));
}
