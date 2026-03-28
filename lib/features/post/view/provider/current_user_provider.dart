import 'package:conet_app/features/authentication/data/auth_remote_datasource.dart';
import 'package:conet_app/features/authentication/model/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentUserProvider = FutureProvider<UserModel?>((ref) async {
  final auth = AuthRemoteDatasource();
  return await auth.getCurrentUser();
});
