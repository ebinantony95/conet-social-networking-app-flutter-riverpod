class DiscoverUser {
  final String id;
  final String name;
  final String avatar;
  final String interest;
  final String wantsToLearn;

  DiscoverUser({
    required this.id,
    required this.name,
    required this.avatar,
    required this.interest,
    required this.wantsToLearn,
  });

  factory DiscoverUser.fromFirestore(Map<String, dynamic> data, String id) {
    return DiscoverUser(
      id: id,
      name: data['name'] ?? '',
      avatar: data['avatar'] ?? '',

      interest: (data['interests'] as List?)?.isNotEmpty == true
          ? data['interests'][0]
          : '',

      wantsToLearn: (data['learning'] as List?)?.isNotEmpty == true
          ? data['learning'][0]
          : '',
    );
  }
}
