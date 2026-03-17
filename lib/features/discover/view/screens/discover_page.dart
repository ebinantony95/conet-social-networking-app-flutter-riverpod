import 'package:conet_app/features/discover/view%20model/discover_view_model.dart';
import 'package:conet_app/features/discover/view/widgets/dicovery_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DiscoverPage extends ConsumerWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(discoverProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Discover")),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text("Error: $e")),
        data: (users) {
          return GridView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: users.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.75,
            ),
            itemBuilder: (context, index) {
              final user = users[index];

              return DiscoverCard(
                user: user,
                onClose: () =>
                    ref.read(discoverProvider.notifier).moveToBottom(index),
                onConnect: () =>
                    ref.read(discoverProvider.notifier).connect(user.id),
              );
            },
          );
        },
      ),
    );
  }
}
