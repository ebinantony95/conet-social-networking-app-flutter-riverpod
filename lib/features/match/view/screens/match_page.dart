import 'package:conet_app/features/authentication/data/auth_remote_datasource.dart';
import 'package:conet_app/features/authentication/model/user_model.dart';
import 'package:conet_app/features/match/view%20model/match_view_model.dart';
import 'package:conet_app/features/match/view/widgets/match_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:go_router/go_router.dart';

class MatchPage extends ConsumerStatefulWidget {
  const MatchPage({super.key});

  @override
  ConsumerState<MatchPage> createState() => _MatchPageState();
}

class _MatchPageState extends ConsumerState<MatchPage> {
  final CardSwiperController controller = CardSwiperController();

  UserModel? currentUser;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    final auth = AuthRemoteDatasource();

    final user = await auth.getCurrentUser(); // 👈 IMPORTANT

    if (user != null) {
      currentUser = user;

      await ref.read(matchProvider.notifier).loadMatches(user);
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final users = ref.watch(matchProvider);

    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (users.isEmpty) {
      return const Scaffold(body: Center(child: Text("No matches found")));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Match",
          style: Theme.of(
            context,
          ).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.w900),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: CardSwiper(
              controller: controller,
              cardsCount: users.length,
              numberOfCardsDisplayed: users.length >= 3 ? 3 : users.length,

              onSwipe: (prev, curr, direction) async {
                final vm = ref.read(matchProvider.notifier);

                if (direction == CardSwiperDirection.right) {
                  final match = await vm.like();

                  if (match != null && context.mounted) {
                    context.push('/match-success', extra: match);
                  }
                } else {
                  await vm.pass();
                }

                return true;
              },

              cardBuilder: (context, index, _, _) {
                if (index >= users.length) return const SizedBox();
                return MatchCard(user: users[index]);
              },
            ),
          ),

          /// BUTTONS
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _btn(Icons.close, Colors.red, () {
                  controller.swipe(CardSwiperDirection.left);
                }),
                _btn(Icons.favorite, Colors.pink, () {
                  controller.swipe(CardSwiperDirection.right);
                }, big: true),
                // _btn(Icons.star, Colors.purple, () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _btn(
    IconData icon,
    Color color,
    VoidCallback onTap, {
    bool big = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: big ? 70 : 60,
        height: big ? 70 : 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(blurRadius: 10, color: Colors.black.withOpacity(0.1)),
          ],
        ),
        child: Icon(icon, color: color),
      ),
    );
  }
}
