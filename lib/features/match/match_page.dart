import 'package:conet_app/features/authentication/view_model/auth_viewmodel_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MatchPage extends ConsumerWidget {
  const MatchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            ref.read(authViewModelProvider.notifier).logout();
          },
          child: Text('MatchPage'),
        ),
      ),
    );
  }
}
