import 'package:conet_app/features/discover/view%20model/discover_view_model.dart';
import 'package:conet_app/features/discover/view/screens/dicovery_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DiscoverPage extends ConsumerWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(discoverProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Discover")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: state.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text("Error: $e")),
            data: (users) {
              return ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: DiscoverCard(
                      user: user,
                      onClose: () => ref
                          .read(discoverProvider.notifier)
                          .moveToBottom(index),
                      onConnect: () =>
                          ref.read(discoverProvider.notifier).connect(user.id),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
