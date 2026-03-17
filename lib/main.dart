import 'package:conet_app/app.dart';
import 'package:conet_app/features/discover/model/hive_discover_model.dart';
import 'package:conet_app/features/profile/model/profile_model.dart';
import 'package:conet_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await Hive.initFlutter();

  /// Existing
  Hive.registerAdapter(UserProfileAdapter());

  /// NEW
  Hive.registerAdapter(DiscoverUserHiveAdapter());

  /// Existing
  await Hive.openBox<UserProfile>('profileBox');

  /// NEW
  await Hive.openBox<DiscoverUserHive>('discoverBox');

  runApp(const ProviderScope(child: App()));
}
