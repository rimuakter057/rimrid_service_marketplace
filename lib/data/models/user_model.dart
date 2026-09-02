class UserModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final int avatarSeed;
  final String address;
  final bool isProvider;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.avatarSeed,
    required this.address,
    this.isProvider = false,
  });

  UserModel copyWith({
    String? name,
    String? email,
    String? phone,
    String? address,
  }) {
    return UserModel(
      id: id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      avatarSeed: avatarSeed,
      address: address ?? this.address,
      isProvider: isProvider,
    );
  }
}
